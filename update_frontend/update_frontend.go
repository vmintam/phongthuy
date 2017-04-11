package main

import (
	"bytes"
	"crypto/md5"
	"crypto/sha256"
	"crypto/tls"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"math/rand"
	"muvik/utilities/amqp"
	"net/http"
	"net/url"
	"os"
	log "phongthuy/utilities/logging"
	"strings"
	//	"strings"
	"database/sql"
	"strconv"
	"sync"
	"time"

	"github.com/BurntSushi/toml"
	_ "github.com/go-sql-driver/mysql"
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

var sqldb *sql.DB

const (
	CALLBACK                = `/callback_authentication`
	SPID                    = `001011`
	CPID                    = `001011`
	USERNAME                = `phongthuynguhanh`
	PASSWORD                = `phongthuy@123p`
	API_CREATE_USER         = `http://cms.phongthuynguhanh.com.vn/api/savecustomer.html`
	API_UPDATE_CATE         = `http://cms.phongthuynguhanh.com.vn/api/updatepackagecustomer.html`
	API_UPDATE_STATUS       = `http://cms.phongthuynguhanh.com.vn/api/updatestatuscustomer.html`
	API_UPDATE_PASSWORD     = `http://cms.phongthuynguhanh.com.vn/api/updatepasscustomer.html`
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
func random(min, max int) int {
	rand.Seed(time.Now().Unix())
	return rand.Intn(max-min) + min
}

func GenerateMd5(str string) string {
	data := []byte(str)
	return fmt.Sprintf("%x", md5.Sum(data))
}

func GenerateSHA256(str string) string {
	data := []byte(str)
	return fmt.Sprintf("%x", sha256.Sum256(data))
}

type PasswordMsg struct {
	Interaction string `json:"interaction"`
	Msisdn      string `json:"msisdn"`
	Password    string `json:"password"`
	Source      string `json:"source"`
	Type        string `json:"type"`
	TimeStamp   string `json:"timeStamp"`
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

type UnRegisterMsg struct {
	Interaction   string `json:"interaction"`
	Msisdn        string `json:"msisdn"`
	ServiceCode   string `json:"serviceCode"`
	ShortCode     string `json:"shortcode"`
	SmsMO         string `json:"smsMO"`
	SmsMT         string `json:"smsMT"`
	Source        string `json:"source"`
	Type          string `json:"type"`
	SubCode       string `json:"subCode"`
	ErrorCode     string `json:"wcgErrorCode"`
	TransactionID string `json:"wcgTransactionId"`
	TimeStamp     string `json:"timeStamp"`
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

func updatePasswordFrontend(body []byte) bool {
	newAction := PasswordMsg{}
	if err := json.Unmarshal(body, &newAction); err != nil {
		log.Error("%v", err)
		return false
	}
	create_user := url.Values{}
	create_user.Set("phone", newAction.Msisdn)
	create_user.Add("password", string(newAction.Password[:6]))
	log.Info("POST with data msisdn %s, password %s ", newAction.Msisdn, newAction.Password[:6])
	resp, err := post(API_UPDATE_PASSWORD, bytes.NewBufferString(create_user.Encode()))
	if err != nil {
		log.Error("%v", err)
		return false
	}
	log.Info("resp from API %s", string(resp))
	return true
}

func CreateUser(phone string, password string) (resp Response) {
	create_user := url.Values{}
	create_user.Set("phone", phone)
	create_user.Add("status", "1")
	create_user.Add("received_sms", "0")
	create_user.Add("password", password)
	log.Info("POST with data msisdn %s, password %s ", phone, password)
	body, err := post(API_CREATE_USER, bytes.NewBufferString(create_user.Encode()))
	if err != nil {
		log.Error("%v", err)
		return
	}
	//decode response
	err = json.Unmarshal(body, &resp)
	log.Info("resp from API %s", string(body))
	return resp
}

func UpdatePackage(phone string, pkgcode string, kind string) (resp Response) {
	ud_cate_req := url.Values{}
	ud_cate_req.Set("phone", phone)
	ud_cate_req.Add("type", kind)
	ud_cate_req.Add("package", pkgcode)

	body, err := post(API_UPDATE_CATE, bytes.NewBufferString(ud_cate_req.Encode()))
	if err != nil {
		log.Error("%v", err)
		return
	}
	//decode response
	err = json.Unmarshal(body, &resp)
	log.Info("resp from API %s", string(body))
	return resp
}

//TODO gap msg register -> check xem co phai dk lan dau ko ? neu dk lan dau -> send password vao mt_waiting_send, register vao web + goi tuong ung
//TODO gap msg unregister -> delete goi trong frontend
func UnRegisterHandler(body []byte) bool {
	//TODO gap msg unregister -> delete goi trong frontend
	newAction := UnRegisterMsg{}
	if err := json.Unmarshal(body, &newAction); err != nil {
		log.Error("%v", err)
		return false
	}
	if newAction.ErrorCode == ERROR_CONGTT_SUCCESSFUL {
		//update package vao web
		resp_pkg := UpdatePackage(newAction.Msisdn, strings.Trim(newAction.SubCode, " "), "0")
		if resp_pkg.Error != "0" {
			return false
		}
	}
	return true
}

func RegisterHandler(body []byte) bool {
	//TODO gap msg register -> check xem co phai dk lan dau ko ? neu dk lan dau -> send password vao mt_waiting_send, register vao web + goi tuong ung

	newAction := RegisterMsg{}
	if err := json.Unmarshal(body, &newAction); err != nil {
		log.Error("%v", err)
		return false
	}
	price, _ := strconv.Atoi(newAction.Price)
	//neu thue bao lan dau dk goi nay
	if newAction.ErrorCode == ERROR_CONGTT_SUCCESSFUL {
		if price == 0 {
			//gen password
			myrand := random(100000, 999999)

			//insert into web
			resp := CreateUser(newAction.Msisdn, fmt.Sprintf("%d", myrand))
			//kiem tra xem co insert duoc ko ? neu user chua ton tai, send password vao exchange mt_waiting_send
			if resp.Error == "0" {
				//send password
				send_mt := SendMsg{
					Interaction:   "waiting_mt_send",
					Source:        newAction.Source,
					Msisdn:        newAction.Msisdn,
					TimeStamp:     time.Now().Format(LAYOUT),
					ShortCode:     newAction.ShortCode,
					SmsMO:         "",
					SubCode:       EMessageType["SYSTEM_CONTENT"],
					SmsMT:         fmt.Sprintf("Mời bạn truy cập http://phongthuynguhanh.com.vn để sử dụng dịch vụ. user truy cập: %s, mật khẩu: %d .Trân trọng cảm ơn", newAction.Msisdn, myrand),
					Type:          newAction.Type,
					RequestID:     fmt.Sprintf("%s%d", "req_", time.Now().UnixNano()),
					TransactionID: newAction.TransactionID,
				}
				send_mt_json, _ := json.Marshal(send_mt)
				//push
				gs.PushMsg <- send_mt_json
			} else if resp.Error == "2" {
				//TODO update password
				update_pass := url.Values{}
				update_pass.Set("phone", newAction.Msisdn)
				update_pass.Add("password", fmt.Sprintf("%d", myrand))
				log.Info("POST with data msisdn %s, password %s ", newAction.Msisdn, fmt.Sprintf("%d", myrand))
				resp, err := post(API_UPDATE_PASSWORD, bytes.NewBufferString(update_pass.Encode()))
				if err != nil {
					log.Error("%v", err)
					return false
				}
				log.Info("resp from API %s", string(resp))
				//send to mt queue
				//send password
				send_mt := SendMsg{
					Interaction:   "waiting_mt_send",
					Source:        newAction.Source,
					Msisdn:        newAction.Msisdn,
					TimeStamp:     time.Now().Format(LAYOUT),
					ShortCode:     newAction.ShortCode,
					SmsMO:         "",
					SubCode:       EMessageType["SYSTEM_CONTENT"],
					SmsMT:         fmt.Sprintf("Mời bạn truy cập http://phongthuynguhanh.com.vn để sử dụng dịch vụ. user truy cập: %s, mật khẩu: %d .Trân trọng cảm ơn", newAction.Msisdn, myrand),
					Type:          newAction.Type,
					RequestID:     fmt.Sprintf("%s%d", "req_", time.Now().UnixNano()),
					TransactionID: newAction.TransactionID,
				}
				send_mt_json, _ := json.Marshal(send_mt)
				//push
				gs.PushMsg <- send_mt_json
			}
		}
		//update package vao web
		resp_pkg := UpdatePackage(newAction.Msisdn, strings.Trim(newAction.SubCode, " "), "1")
		if resp_pkg.Error != "0" {
			return false
		}
	}
	return true

}

func main() {
	//make proceducer
	gs.Wait.Add(1)
	go amqputil.MakeProducer(&gs.Wait, conf.RabbitMq.Uri, conf.RabbitMq.Producer["waiting_mt_send"].Exchange, conf.RabbitMq.Producer["waiting_mt_send"].Key, gs.PushMsg)

	//make consumer
	gs.Wait.Add(1)
	go amqputil.MakeConsumer(&gs.Wait, conf.RabbitMq.Uri, conf.RabbitMq.Consumer["password"].Queue, updatePasswordFrontend)
	gs.Wait.Add(1)
	go amqputil.MakeConsumer(&gs.Wait, conf.RabbitMq.Uri, conf.RabbitMq.Consumer["recevie_register_sub"].Queue, RegisterHandler)
	gs.Wait.Add(1)
	go amqputil.MakeConsumer(&gs.Wait, conf.RabbitMq.Uri, conf.RabbitMq.Consumer["recevie_un_register_sub"].Queue, UnRegisterHandler)
	defer gs.Wait.Wait()

}
