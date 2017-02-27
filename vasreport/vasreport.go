package main

import (
	//	"net/http"
	"database/sql"
	"fmt"
	"os"
	log "phongthuy/utilities/logging"
	"strings"
	"time"

	"github.com/BurntSushi/toml"
	_ "github.com/go-sql-driver/mysql"
	"github.com/jlaffaye/ftp"
)

type MySqlConf struct {
	Connection  string `toml:"connection"`
	IdleConnNum int    `toml:"idle_conn"`
	MaxConnNum  int    `toml:"max_conn"`
}

type MiscConf struct {
	VAS_FTP      string `toml:"vas_ftp"`
	VAS_USERNAME string `toml:"vas_username"`
	VAS_PASSWORD string `toml:"vas_password"`
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
	VAS_MADV_ACTIVE     = `MADV_active_%s`
	VAS_MADV_REGISTER   = `MADV_register_%s`
	VAS_MADV_UNREGISTER = `MADV_unregister_%s`
	LAYOUT              = "20060201"
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

func getYesterday() string {
	return time.Now().AddDate(0, 0, -1).Format(LAYOUT)

}

type ACTIVE struct {
	Msisdn    string
	SubCode   string
	StartDate string
	EndDate   string
}

func activeHandle() (result string, err error) {
	rows, err := sqldb.Query("SELECT msisdn,subCode,lastchargedate as startdate, enddate as enddate FROM userbases where status in (1,2,4) ;")
	if err != nil {
		log.Error("%v", err)
		return "", err
	}
	for rows.Next() {
		r := ACTIVE{}
		if err := rows.Scan(&r.Msisdn, &r.SubCode, &r.StartDate, &r.EndDate); err != nil {
			log.Error("Mysql error %s", err)
			return "", err
		}
		result = result + fmt.Sprintf("%s,%s,%s,%s\n", r.Msisdn, r.SubCode, r.StartDate, r.EndDate)
	}
	return result, nil
}

func registerHandle() {

}

func unRegisterHandle() {

}
func main() {

	active, err := activeHandle()
	if err != nil {
		log.Error("%v", err)
	}
	client, err := ftp.Connect(conf.Misc.VAS_FTP)
	if err != nil {
		panic(err)
	}
	defer client.Quit()

	err = client.Login(conf.Misc.VAS_USERNAME, conf.Misc.VAS_PASSWORD)
	if err != nil {
		panic(err)
	}
	err = client.Stor(fmt.Sprintf(VAS_MADV_ACTIVE, getYesterday()), strings.NewReader(active))
	if err != nil {
		panic(err)
	}
	activeHandle()
}
