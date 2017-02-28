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
	LAYOUT_FPT          = "20060201"
	LAYOUT_DB           = "2006-02-01"
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

func getYesterdayFTP() string {
	return time.Now().AddDate(0, 0, -1).Format(LAYOUT_FPT)

}

func getYesterdayDB() string {
	return time.Now().AddDate(0, 0, -1).Format(LAYOUT_DB)

}

type ACTIVE struct {
	Msisdn    string
	SubCode   string
	StartDate string
	EndDate   string
}

type REGISTER struct {
	Msisdn    string
	SubCode   string
	StartDate string
	EndDate   string
	Status    string
	Channel   string
}

type UNREGISTER struct {
	Msisdn    string
	SubCode   string
	StartDate string
	EndDate   string
	Channel   string
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

var EStatusType = map[string]int{
	"4": 0, //gia han
	"1": 1, //dk moi
	"2": 2, //dk lai
}

var EType = map[string]int{
	"SMS":    0, //huy tu sms
	"CongTT": 1, //huy tu he thong
	"CSKH":   1, //huy tu he thong
	"WEB":    0, //huy tu web
}

//report user gia han, dk moi, dk lai trong ngay MSISDN,Magoi,StartDate,EndDate,Type, channel
func registerHandle() (result string, err error) {
	query := fmt.Sprintf("SELECT msisdn,subCode,lastchargedate as startdate, enddate as enddate, status, source FROM userbases where status in (1,2,4) and updated_at > '%s 00:00:00' and updated_at <= '%s 23:59:59';", getYesterdayDB(), getYesterdayDB())
	rows, err := sqldb.Query(query)
	if err != nil {
		log.Error("%v", err)
		return "", err
	}
	for rows.Next() {
		r := REGISTER{}
		if err := rows.Scan(&r.Msisdn, &r.SubCode, &r.StartDate, &r.EndDate, &r.Status, &r.Channel); err != nil {
			log.Error("Mysql error %s", err)
			return "", err
		}
		result = result + fmt.Sprintf("%s,%s,%s,%s,%d,%s\n", r.Msisdn, r.SubCode, r.StartDate, r.EndDate, EStatusType[r.Status], r.Channel)
	}
	return result, nil
}

func unRegisterHandle() (result string, err error) {
	query := fmt.Sprintf("SELECT msisdn,subCode,lastchargedate as startdate, enddate as enddate, source FROM userbases where status=3 and updated_at > '%s 00:00:00' and updated_at <= '%s 23:59:59';", getYesterdayDB(), getYesterdayDB())
	rows, err := sqldb.Query(query)
	if err != nil {
		log.Error("%v", err)
		return "", err
	}
	for rows.Next() {
		r := UNREGISTER{}
		if err := rows.Scan(&r.Msisdn, &r.SubCode, &r.StartDate, &r.EndDate, &r.Channel); err != nil {
			log.Error("Mysql error %s", err)
			return "", err
		}
		result = result + fmt.Sprintf("%s,%s,%s,%s,%d,%s\n", r.Msisdn, r.SubCode, r.StartDate, r.EndDate, EType[r.Channel], r.Channel)
	}
	return result, nil
}
func main() {

	active, err := activeHandle()
	if err != nil {
		log.Error("%v", err)
	}
	register, err := registerHandle()
	if err != nil {
		log.Error("%v", err)
	}
	unregister, err := unRegisterHandle()
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
	//day file active
	err = client.Stor(fmt.Sprintf(VAS_MADV_ACTIVE, getYesterdayFTP()), strings.NewReader(active))
	if err != nil {
		panic(err)
	}
	//day file register
	err = client.Stor(fmt.Sprintf(VAS_MADV_REGISTER, getYesterdayFTP()), strings.NewReader(register))
	if err != nil {
		panic(err)
	}
	//day file unregister
	err = client.Stor(fmt.Sprintf(VAS_MADV_UNREGISTER, getYesterdayFTP()), strings.NewReader(unregister))
	if err != nil {
		panic(err)
	}
}
