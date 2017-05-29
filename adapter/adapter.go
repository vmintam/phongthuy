package main

import (
	"crypto/md5"
	"crypto/sha256"
	"fmt"
	"net/http"
	"os"
	log "phongthuy/utilities/logging"
	//	"strings"
	"bytes"
	"crypto/tls"
	"database/sql"
	"encoding/json"
	"io/ioutil"
	"muvik/utilities/amqp"
	"sync"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/BurntSushi/toml"
	"github.com/gin-gonic/gin"
)

type MySqlConf struct {
	Connection  string `toml:"connection"`
	IdleConnNum int    `toml:"idle_conn"`
	MaxConnNum  int    `toml:"max_conn"`
}

type RabbitMqConf struct {
	Uri      string                     `toml:"uri"`
	Consumer map[string]RabbitMqConConf `toml:"consumer"`
	Producer map[string]RabbitMqProConf `toml:"producer"`
}

type RabbitMqProConf struct {
	Exchange string `toml:"exchange"`
	Key      string `toml:"key"`
}
type RabbitMqConConf struct {
	Queue string `toml:"queue"`
}

type ServerConf struct {
	Binding string `toml:"bind"`
}

type MiscConf struct {
	RedirectTime    int64  `toml:"redirect_time"`
	ThreeDayContent string `toml:"threeday_content"`
	VSType          int    `toml:"vs_content"`
}

type BGConf struct {
	MySql    MySqlConf    `toml:"mysql"`
	RabbitMq RabbitMqConf `toml:"rabbitmq"`
	Server   ServerConf   `toml:"server"`
	Misc     MiscConf     `toml:"misc"`
}

var (
	conf  BGConf
	sqldb *sql.DB
)

type GlobalSession struct {
	Wait              sync.WaitGroup
	PushMsgUnRegister chan []byte
	PushMsgRegister   chan []byte
	PushMT            chan []byte
}

var gs *GlobalSession = &GlobalSession{
	Wait:              sync.WaitGroup{},
	PushMsgRegister:   make(chan []byte, 10),
	PushMsgUnRegister: make(chan []byte, 10),
	PushMT:            make(chan []byte, 10),
}

const (
	ADAPTER                 = `/adapter`
	SEND_MSG                = `/send`
	SPID                    = `001011`
	CPID                    = `001011`
	USERNAME                = `phongthuynguhanh`
	PASSWORD                = `phongthuy@123p`
	ERROR_CONGTT_SUCCESSFUL = "WCG-0000"
	LAYOUT                  = "2006-02-01 15:04:01"
	VANSU_LAYOUT            = "20060102"
)

func post(url string, data *bytes.Buffer) (body []byte, err error) {
	log.Info("URL %s", url)
	tr := &http.Transport{
		TLSClientConfig: &tls.Config{InsecureSkipVerify: true},
	}
	timeout := time.Duration(30 * time.Second)
	client := &http.Client{
		Timeout:   timeout,
		Transport: tr,
	}
	r, _ := http.NewRequest("POST", url, data) // <-- URL-encoded payload
	r.Header.Add("Content-Type", "application/x-www-form-urlencoded")

	resp, err := client.Do(r)
	if err != nil {
		return
	}
	defer resp.Body.Close()
	body, err = ioutil.ReadAll(resp.Body)
	if err != nil {
		log.Error("%v", err)
		return
	}
	return

}

type Response struct {
	Error json.Number `json:"err,Number"`
	Msg   string      `json:"msg"`
}

type RegisterMsg struct {
	Interaction   string `json:"interaction"`
	Msisdn        string `json:"msisdn"`
	ServiceCode   string `json:"serviceCode"`
	ShortCode     string `json:"shortcode"`
	SmsMO         string `json:"smsMO"`
	SmsMT         string `json:"smsMT"`
	Source        string `json:"source"`
	Price         string `json:"price"`
	Type          string `json:"type"`
	SubCode       string `json:"subCode"`
	ErrorCode     string `json:"wcgErrorCode"`
	TransactionID string `json:"wcgTransactionId"`
	TimeStamp     string `json:"timeStamp"`
}

func init() {
	//innitial config file

	if len(os.Args) < 2 {
		print("Not enough parameters \n")
		os.Exit(1)
	}
	if _, err := toml.DecodeFile(os.Args[1], &conf); err != nil {
		print(err.Error())
		os.Exit(1)
	}
	log.Info("%+v", conf)
	//Init mysql
	// this line define error below is very important
	var err error
	sqldb, err = sql.Open("mysql", conf.MySql.Connection)
	if err != nil {
		log.Error("Open sql connection %s", err)
	}

	sqldb.SetMaxIdleConns(conf.MySql.IdleConnNum)
	sqldb.SetMaxOpenConns(conf.MySql.MaxConnNum)

	err = sqldb.Ping()

	if err != nil {
		log.Error("Mysql ping sql user info error: %s", err)
	}

}

func GenerateMd5(str string) string {
	data := []byte(str)
	return fmt.Sprintf("%x", md5.Sum(data))
}

func GenerateSHA256(str string) string {
	data := []byte(str)
	return fmt.Sprintf("%x", sha256.Sum256(data))
}

var EMessageType = map[string]string{
	"USER_REGISTER":      "USER_REGISTER",
	"SYSTEM_UNREGISTER":  "SYSTEM_UNREGISTER",
	"FORWARD":            "FORWARD",
	"SYSTEM_CONTENT":     "SYSTEM_CONTENT",
	"USER_UNREGISTER":    "USER_UNREGISTER",
	"USER_RE_REGISTER":   "USER_RE_REGISTER",
	"SYSTEM_EXTEND":      "SYSTEM_EXTEND",
	"SYSTEM_REGISTER":    "SYSTEM_REGISTER",
	"SYSTEM_RE_REGISTER": "SYSTEM_RE_REGISTER",
}

var ETypeALl = map[string]int{
	"USER_REGISTER":      1,
	"SYSTEM_UNREGISTER":  2,
	"FORWARD":            3,
	"SYSTEM_CONTENT":     4,
	"USER_UNREGISTER":    5,
	"USER_RE_REGISTER":   6,
	"SYSTEM_EXTEND":      7,
	"SYSTEM_REGISTER":    8,
	"SYSTEM_RE_REGISTER": 9,
}

type PhoneMsg struct {
	Msisdns []string `json:"msisdns"`
	Type    int      `json:"type"`
}

type SendMsg struct {
	Interaction   string `json:"interaction"`
	Msisdn        string `json:"msisdn"`
	RequestID     string `json:"requestid"`
	ShortCode     string `json:"shortcode"`
	SmsMO         string `json:"smsMO"`
	SmsMT         string `json:"smsMT"`
	Source        string `json:"source"`
	Type          string `json:"type"`
	SubCode       string `json:"subCode"`
	TransactionID string `json:"wcgTransactionId"`
	TimeStamp     string `json:"timeStamp"`
}

func getContentByDay() (content string) {
	now := time.Now().Format(VANSU_LAYOUT)
	log.Info("time now %s", now)
	err := sqldb.QueryRow("select content from vansu where date = ?", now).Scan(&content)
	if err != nil {
		log.Error("%v", err)
		return ""
	}
	return content
}

func Sendmsg_Handler(ctx *gin.Context) {
	//get body json
	decode := json.NewDecoder(ctx.Request.Body)
	phones := PhoneMsg{}

	if err := decode.Decode(&phones); err != nil {
		log.Error("cannot decode json from POST")
		return
	}
	log.Info("POST with data %v", phones.Msisdns)
	//	content := ""
	//	if phones.Type == conf.Misc.VSType {
	//		content = getContentByDay()
	//	} else {
	//		content = conf.Misc.ThreeDayContent
	//	}

	//build msg
	for _, msisdn := range phones.Msisdns {
		send_mt := SendMsg{
			Interaction:   "waiting_mt_send",
			Source:        "PTNH",
			Msisdn:        msisdn,
			TimeStamp:     time.Now().Format(LAYOUT),
			ShortCode:     "9432",
			SmsMO:         "",
			SubCode:       "",
			SmsMT:         fmt.Sprintf(conf.Misc.ThreeDayContent, msisdn),
			Type:          EMessageType["SYSTEM_CONTENT"],
			RequestID:     fmt.Sprintf("%s%d", "req_", time.Now().UnixNano()),
			TransactionID: fmt.Sprintf("%s%d", "trans_", time.Now().UnixNano()),
		}
		raw, _ := json.Marshal(send_mt)
		//push
		gs.PushMT <- raw
		log.Info("send to rabbitmq OK")
	}

}
func Adapter_Handler(ctx *gin.Context) {

	//get body json
	decode := json.NewDecoder(ctx.Request.Body)
	register := RegisterMsg{}
	if err := decode.Decode(&register); err != nil {
		log.Error("cannot decode json from POST")
		return
	}
	raw, _ := json.Marshal(register)
	//push
	if register.Interaction == "recevie_register_sub" {
		gs.PushMsgRegister <- raw
	} else {
		gs.PushMsgUnRegister <- raw
	}

	log.Info("send to rabbitmq OK")
}

func main() {
	//make proceducer
	gs.Wait.Add(1)
	go amqputil.MakeProducer(&gs.Wait, conf.RabbitMq.Uri, conf.RabbitMq.Producer["recevie_register_sub"].Exchange, conf.RabbitMq.Producer["recevie_register_sub"].Key, gs.PushMsgRegister)

	gs.Wait.Add(1)
	go amqputil.MakeProducer(&gs.Wait, conf.RabbitMq.Uri, conf.RabbitMq.Producer["recevie_un_register_sub"].Exchange, conf.RabbitMq.Producer["recevie_register_sub"].Key, gs.PushMsgUnRegister)

	gs.Wait.Add(1)
	go amqputil.MakeProducer(&gs.Wait, conf.RabbitMq.Uri, conf.RabbitMq.Producer["waiting_mt_send"].Exchange, conf.RabbitMq.Producer["waiting_mt_send"].Key, gs.PushMT)
	defer gs.Wait.Wait()

	//go-gin
	g := gin.Default()
	g.POST(ADAPTER, Adapter_Handler)
	g.POST(SEND_MSG, Sendmsg_Handler)
	g.Run(conf.Server.Binding)
	log.Info("go-gin server start...")

}
