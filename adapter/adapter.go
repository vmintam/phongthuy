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
	"encoding/json"
	"io/ioutil"
	"muvik/utilities/amqp"
	"sync"
	"time"

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
	RedirectTime int64 `toml:"redirect_time"`
}

type BGConf struct {
	MySql    MySqlConf    `toml:"mysql"`
	RabbitMq RabbitMqConf `toml:"rabbitmq"`
	Server   ServerConf   `toml:"server"`
	Misc     MiscConf     `toml:"misc"`
}

var (
	conf BGConf
)

type GlobalSession struct {
	Wait    sync.WaitGroup
	PushMsg chan []byte
}

var gs *GlobalSession = &GlobalSession{
	Wait:    sync.WaitGroup{},
	PushMsg: make(chan []byte, 10),
}

const (
	ADAPTER                 = `/adapter`
	SPID                    = `001011`
	CPID                    = `001011`
	USERNAME                = `phongthuynguhanh`
	PASSWORD                = `phongthuy@123p`
	ERROR_CONGTT_SUCCESSFUL = "WCG-0000"
	LAYOUT                  = "2006-02-01 15:04:01"
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
	gs.PushMsg <- raw
	log.Info("send to rabbitmq OK")
}

func main() {
	//make proceducer
	gs.Wait.Add(1)
	go amqputil.MakeProducer(&gs.Wait, conf.RabbitMq.Uri, conf.RabbitMq.Producer["recevie_register_sub"].Exchange, conf.RabbitMq.Producer["recevie_register_sub"].Key, gs.PushMsg)
	defer gs.Wait.Wait()

	//go-gin
	g := gin.Default()
	g.POST(ADAPTER, Adapter_Handler)
	g.Run(conf.Server.Binding)
	log.Info("go-gin server start...")

}
