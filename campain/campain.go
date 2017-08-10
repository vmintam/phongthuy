package main

import (
	"bytes"
	"crypto/md5"
	"crypto/sha256"
	"crypto/tls"
	"database/sql"
	"fmt"
	"io/ioutil"
	"net/http"
	"os"
	log "phongthuy/utilities/logging"
	"strings"
	"time"

	"github.com/BurntSushi/toml"
	"github.com/gin-gonic/gin"
	_ "github.com/go-sql-driver/mysql"
)

type MySqlConf struct {
	Connection  string `toml:"connection"`
	IdleConnNum int    `toml:"idle_conn"`
	MaxConnNum  int    `toml:"max_conn"`
}

type ServerConf struct {
	Binding string `toml:"bind"`
}

type MiscConf struct {
	RedirectTime int64  `toml:"redirect_time"`
	BaseURL      string `toml:"base_url"`
}

type BGConf struct {
	Server ServerConf `toml:"server"`
	Misc   MiscConf   `toml:"misc"`
	MySql  MySqlConf  `toml:"mysql"`
}

var (
	conf  BGConf
	sqldb *sql.DB
)

const (
	CAMPAIN   = `/campain`
	SPID      = `001011`
	CPID      = `001011`
	USERNAME  = `phongthuynguhanh`
	PASSWORD  = `phongthuy@123p`
	REGTYPE   = "1"
	SHOTCODE  = "9432"
	RETURNURL = "http://phongthuynguhanh.com.vn/callback_authentication"
	LAYOUT    = "2006-01-02 15:04:01" // phai la 2006-01-02, ko duoc 2006-02-01
	POSTFIX   = `spid=%s&cpid=%s&transaction_id=%s&return_url=%s&pkg_code=%s&type=%s&shortcode=%s&hashstring=%s`
)

func GenerateMd5(str string) string {
	data := []byte(str)
	return fmt.Sprintf("%x", md5.Sum(data))
}

func GenerateSHA256(str string) string {
	data := []byte(str)
	return fmt.Sprintf("%x", sha256.Sum256(data))
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

func CallBack_Handler(ctx *gin.Context) {
	msisdn := ctx.Request.Header.Get("msisdn")
	log.Info("%s", msisdn)
	source := ctx.DefaultQuery("source", "ptnh")
	log.Info("%s", source)
	pkg_code := strings.ToUpper(ctx.DefaultQuery("pkg_code", "VIP"))
	transaction_id := fmt.Sprintf("%d", time.Now().UnixNano())
	inEncode := SPID + CPID + transaction_id + pkg_code + RETURNURL + REGTYPE + SHOTCODE + USERNAME + GenerateMd5(GenerateMd5(PASSWORD))
	inEncode = fmt.Sprintf("%s%d", inEncode, len(inEncode))
	hashstring := GenerateSHA256(inEncode)

	//log all
	redirect := conf.Misc.BaseURL + fmt.Sprintf(POSTFIX, SPID, CPID, transaction_id, RETURNURL, pkg_code, REGTYPE, SHOTCODE, hashstring)
	log.Info("redirect link %s", redirect)
	// check type is register or unregister
	ctx.Redirect(http.StatusMovedPermanently, redirect)
	//insert into database
	query := fmt.Sprintf("insert into `campains` (`source`,`package`,`msisdn`) values ('%s', '%s', '%s')", source, strings.ToUpper(pkg_code), msisdn)
	log.Info(query)
	_, err := sqldb.Exec(query)
	if err != nil {
		log.Error("%v", err)
		return
	}
}

func main() {

	//go-gin
	g := gin.Default()
	g.GET(CAMPAIN, CallBack_Handler)
	g.Run(conf.Server.Binding)
	log.Info("go-gin server start...")

}
