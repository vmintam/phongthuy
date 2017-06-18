package main

import (
	"fmt"
	"os"
	"time"

	"database/sql"
	"net/http"
	log "phongthuy/utilities/logging"
	"unicode"

	"strings"

	"github.com/BurntSushi/toml"
	"github.com/PuerkitoBio/goquery"
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

var (
	//Horoscope
	HOROSCOPE = map[string]string{
		"aries":       "BẠCH DƯƠNG",
		"taurus":      "KIM NGƯU",
		"gemini":      "SONG TỬ",
		"cancer":      "CỰ GIẢI",
		"leo":         "SƯ TỬ",
		"virgo":       "XỬ NỮ",
		"libra":       "THIÊN BÌNH",
		"scorpius":    "HỔ CÁP",
		"sagittarius": "NHÂN MÃ",
		"capricornus": "MA KẾT",
		"aquarius":    "BẢO BÌNH",
		"pisces":      "SONG NGƯ",
	}
)

const ()

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

func stringMinifier(in string) (out string) {
	white := false
	for _, c := range in {
		if unicode.IsSpace(c) {
			if !white {
				out = out + " "
			}
			white = true
		} else {
			out = out + string(c)
			white = false
		}
	}
	return
}

func getHoangDao(url string) error {
	timeout := time.Duration(5 * time.Second)
	client := &http.Client{
		Timeout: timeout,
	}
	resp, err := client.Get(url)
	if err != nil {
		log.Error("%v", err)
		return err
	}
	defer resp.Body.Close()
	doc, err := goquery.NewDocumentFromResponse(resp)
	if err != nil {
		fmt.Printf("%v", err)
		return err
	}
	fmt.Println("---- Starting to parse ------------------------")
	// Find reddit posts = elements with class "thing"
	spans := doc.Find(".kconten_item span")
	for sp := range spans.Nodes {
		thing := spans.Eq(sp)
		if thing.Find("h3").Text() == "" {
			continue
		}
		for _, horo := range HOROSCOPE {
			if strings.Contains(strings.ToUpper(thing.Find("h3").Text()), horo) {
				content, err := spans.Eq(sp).Each(func(_ int, s *goquery.Selection) {
					s.Find("img").Remove()
					s.Find(".imagecontainer").Remove()
					s.Find("a").Remove()
					s.Find("table").Remove()
					s.Find("strong").Remove()
				}).Html()
				log.Info(content)
				if err != nil {
					log.Error("%v", err)
					continue
				}
			}

		}

	}
	return nil

}

func getVanSu(url string) error {
	timeout := time.Duration(5 * time.Second)
	client := &http.Client{
		Timeout: timeout,
	}
	resp, err := client.Get(url)
	if err != nil {
		log.Error("%v", err)
		return err
	}
	defer resp.Body.Close()
	doc, err := goquery.NewDocumentFromResponse(resp)
	if err != nil {
		fmt.Printf("%v", err)
		return err
	}
	fmt.Println("---- Starting to parse Van Su------------------------")
	// Find reddit posts = elements with class "thing"
	atags := doc.Find(".text_baiviet a")
	for tag := range atags.Nodes {
		singles := atags.Eq(tag)
		ahref, exists := singles.Attr("href")
		if exists == true {
			log.Info(ahref)
		}
	}
	return nil

}

func insertDB(table string, data map[string]string) bool {
	// insert into DB
	switch table {
	case "horoscope":
		_, err := sqldb.Exec(`insert into horoscope (cung, status, content) 
		values (?, ?, ?, ?, ?, ?, ?, ?, ?)`, data["dr"], data["vy"], data["vm"], data["gd"], data["hh"], data["dd"], data["mm"], data["yy"], data["content"])
		if err != nil {
			log.Error("%v", err)
			return false
		}
	case "fortune":
		_, err := sqldb.Exec(`insert into huongnha (huongcua, namxay, thangxay, gender, giosinh, ngaysinh, thangsinh, namsinh, content) 
		values (?, ?, ?, ?, ?, ?, ?, ?, ?)`, data["dr"], data["vy"], data["vm"], data["gd"], data["hh"], data["dd"], data["mm"], data["yy"], data["content"])
		if err != nil {
			log.Error("%v", err)
			return false
		}

	default:
	}
	return true
}

func main() {
	// getHoangDao("http://lichngaytot.com/tu-vi-ngay-19-06-2017.html")
	getVanSu("http://lichvansu.wap.vn/tag/12-con-giap.html")
	log.Info("this is main function")
}
