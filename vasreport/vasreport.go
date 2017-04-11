package main

import (
	//	"net/http"
	"database/sql"
	"fmt"
	"os"
	log "phongthuy/utilities/logging"
	//	"strings"
	"io/ioutil"
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
	VAS_MADV_ACTIVE     = `files/phongthuynguhanh_active_%s.txt`
	VAS_MADV_REGISTER   = `files/phongthuynguhanh_register_%s.txt`
	VAS_MADV_UNREGISTER = `files/phongthuynguhanh_unregister_%s.txt`
	KPI_REGISTER        = `files/phongthuynguhanh_REG_SUCC_%s.txt`
	KPI_UNREGISTER      = `files/phongthuynguhanh_DEL_SUCC_%s.txt`
	KPI_EXTEND          = `files/phongthuynguhanh_EXT_SUCC_%s.txt`
	LAYOUT_FPT          = "20060102"
	LAYOUT_DB           = "2006-01-02"
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

//report user gia han, dk moi, dk lai trong ngay MSISDN,Magoi,StartDate,EndDate,Type, channel
func registerHandle() (result string, err error) {
	query := fmt.Sprintf("SELECT msisdn,subCode, lastchargedate as startdate, enddate as enddate, status, source FROM userbases where status in (1,2,4) and updated_at > '%s 00:00:00' and updated_at <= '%s 23:59:59';", getYesterdayDB(), getYesterdayDB())
	fmt.Println(query)
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
	fmt.Println(query)
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

//kpi register
func kpi_registerHandle() (result string, err error) {
	var total int
	var total_suc int
	//query total
	query_total := fmt.Sprintf("SELECT count(*) as total FROM history_%s where type in (1,6,8,9) limit 1;", getYesterdayFTP())
	fmt.Println(query_total)
	err = sqldb.QueryRow(query_total).Scan(&total)
	if err != nil {
		log.Error("%v", err)
		return "", err
	}
	query_suc := fmt.Sprintf("SELECT count(*) as total_suc FROM history_%s where type in (1,6,8,9) and errorcode != 'WCG-0001' limit 1;", getYesterdayFTP())
	fmt.Println(query_suc)
	err = sqldb.QueryRow(query_suc).Scan(&total_suc)
	if err != nil {
		log.Error("%v", err)
		return "", err
	}
	result = fmt.Sprintf("%d,%d,%.2f", total, total_suc, float32(total_suc/total)*100) + "%"
	return result, nil
}

//kpi unregister
func kpi_unregisterHandle() (result string, err error) {
	var total int
	var total_suc int
	//query total
	query_total := fmt.Sprintf("SELECT count(*) as total FROM history_%s where type in (2,5) limit 1;", getYesterdayFTP())
	fmt.Println(query_total)
	err = sqldb.QueryRow(query_total).Scan(&total)
	if err != nil {
		log.Error("%v", err)
		return "", err
	}
	query_suc := fmt.Sprintf("SELECT count(*) as total_suc FROM history_%s where type in (5,2) and errorcode != 'WCG-0001' limit 1;", getYesterdayFTP())
	fmt.Println(query_suc)
	err = sqldb.QueryRow(query_suc).Scan(&total_suc)
	if err != nil {
		log.Error("%v", err)
		return "", err
	}
	result = fmt.Sprintf("%d,%d,%.2f", total, total_suc, float32(total_suc/total)*100) + "%"
	return result, nil
}

//kpi extend
func kpi_extendHandle() (result string, err error) {
	var total int
	var total_suc int
	//query total
	query_total := fmt.Sprintf("SELECT count(*) as total FROM cdr_%s where type=7 limit 1;", getYesterdayFTP())
	fmt.Println(query_total)
	err = sqldb.QueryRow(query_total).Scan(&total)
	if err != nil {
		log.Error("%v", err)
		return "", err
	}
	query_suc := fmt.Sprintf("SELECT count(*) as total_suc FROM cdr_%s where type=7 and errorcode != 'WCG-0010' limit 1;", getYesterdayFTP())
	fmt.Println(query_suc)
	err = sqldb.QueryRow(query_suc).Scan(&total_suc)
	if err != nil {
		log.Error("%v", err)
		return "", err
	}
	result = fmt.Sprintf("%d,%d,%.2f", total, total_suc, float32(total_suc/total)*100) + "%"
	return result, nil
}

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func main() {

	active, err := activeHandle()
	if err != nil {
		log.Error("%v", err)
	}
	fmt.Println(active)
	register, err := registerHandle()
	if err != nil {
		log.Error("%v", err)
	}
	fmt.Println(register)
	unregister, err := unRegisterHandle()
	if err != nil {
		log.Error("%v", err)
	}
	fmt.Println(unregister)

	//kpi reg
	kpi_reg, err := kpi_registerHandle()
	if err != nil {
		log.Error("%v", err)
	}
	fmt.Println(kpi_reg)

	kpi_unreg, err := kpi_unregisterHandle()
	if err != nil {
		log.Error("%v", err)
	}
	fmt.Println(kpi_unreg)

	kpi_extend, err := kpi_extendHandle()
	if err != nil {
		log.Error("%v", err)
	}
	fmt.Println(kpi_extend)

	//day file active
	err = ioutil.WriteFile(fmt.Sprintf(VAS_MADV_ACTIVE, getYesterdayFTP()), []byte(active), 0644)
	check(err)
	//day file register
	err = ioutil.WriteFile(fmt.Sprintf(VAS_MADV_REGISTER, getYesterdayFTP()), []byte(register), 0644)
	check(err)

	//day file unregister
	err = ioutil.WriteFile(fmt.Sprintf(VAS_MADV_UNREGISTER, getYesterdayFTP()), []byte(unregister), 0644)
	check(err)

	//dong bo KPI vasreport
	err = ioutil.WriteFile(fmt.Sprintf(KPI_EXTEND, getYesterdayFTP()), []byte(kpi_extend), 0644)
	check(err)
	err = ioutil.WriteFile(fmt.Sprintf(KPI_REGISTER, getYesterdayFTP()), []byte(kpi_reg), 0644)
	check(err)
	err = ioutil.WriteFile(fmt.Sprintf(KPI_UNREGISTER, getYesterdayFTP()), []byte(kpi_unreg), 0644)
	check(err)
}
