package main

import (
	"bytes"
	"crypto/tls"
	"database/sql"
	"encoding/json"
	"fmt"
	"io/ioutil"
	log "muvik/utilities/logging"
	"net/http"
	"os"
	"time"

	"github.com/BurntSushi/toml"
	_ "github.com/go-sql-driver/mysql"
)

type MySqlConf struct {
	Connection  string `toml:"connection"`
	IdleConnNum int    `toml:"idle_conn"`
	MaxConnNum  int    `toml:"max_conn"`
}

type MiscConf struct {
	SendDaily    int32  `toml:"send_daily"`
	SendThreeDay int32  `toml:"send_threeday"`
	Url          string `toml:"url"`
	Content      string `toml:"content"`
}
type BGConf struct {
	MySql MySqlConf `toml:"mysql"`
	Misc  MiscConf  `toml:"misc"`
}

var (
	conf  BGConf
	sqldb *sql.DB
)

const (
	DAILY_TYPE    = 0
	THREEDAY_TYPE = 1
)

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

func post(url string, data []byte) (body []byte, err error) {
	log.Info("URL %s", url)
	tr := &http.Transport{
		TLSClientConfig: &tls.Config{InsecureSkipVerify: true},
	}
	timeout := time.Duration(30 * time.Second)
	client := &http.Client{
		Timeout:   timeout,
		Transport: tr,
	}
	r, _ := http.NewRequest("POST", url, bytes.NewBuffer(data)) // <-- URL-encoded payload
	r.Header.Add("Content-Type", "application/json")

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

func getPhoneReceiveSms(kind int) (msisdns []string, err error) {
	sql := fmt.Sprintf("SELECT c.phone from customer c INNER JOIN customer_package_rel a on c.id=a.customer_id  where c.received_sms=%d ;", kind)
	log.Info("%s", sql)
	var msisdn string
	rows, err := sqldb.Query(sql)
	if err != nil {
		log.Error("%v", err)
		return
	}
	for rows.Next() {
		err = rows.Scan(&msisdn)
		if err != nil {
			log.Error("%v", err)
			return
		}
		msisdns = append(msisdns, msisdn)
	}
	return msisdns, nil
}

type SENDMSG struct {
	Msisdns []string `json:"msisdns"`
	Kind    int      `json:"type"`
}

func main() {
	kind := 0
	if conf.Misc.SendDaily == 1 {
		kind = DAILY_TYPE
	}
	if conf.Misc.SendThreeDay == 1 {
		kind = THREEDAY_TYPE
	}
	phones, err := getPhoneReceiveSms(kind)
	log.Info("%s", phones)
	sendmsg := SENDMSG{
		Msisdns: phones,
		Kind:    kind,
	}
	data, err := json.Marshal(sendmsg)
	if err != nil {
		log.Error("%v", err)
		os.Exit(1)
	}
	//SEND to service
	_, err = post(conf.Misc.Url, data)
	if err != nil {
		log.Error("%v", err)
		os.Exit(1)
	}
}
