package main

import (
	"database/sql"
	"fmt"
	"os"
	log "phongthuy/utilities/logging"

	"github.com/BurntSushi/toml"
	_ "github.com/go-sql-driver/mysql"
	"github.com/tealeg/xlsx"
)

type MySqlConf struct {
	Connection  string `toml:"connection"`
	IdleConnNum int    `toml:"idle_conn"`
	MaxConnNum  int    `toml:"max_conn"`
}

type MiscConf struct {
	ExcelFile string `toml:"excel_path"`
}

type BGConf struct {
	MySql MySqlConf `toml:"mysql"`
	Misc  MiscConf  `toml:"misc"`
}

var (
	sqldb *sql.DB
	conf  BGConf
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

func main() {
	excelFileName := conf.Misc.ExcelFile
	xlFile, err := xlsx.OpenFile(excelFileName)
	if err != nil {
		log.Error("%v", err)
	}
	for _, sheet := range xlFile.Sheets {
		for _, row := range sheet.Rows {
			day, _ := row.Cells[0].String()
			content, _ := row.Cells[1].String()
			query := fmt.Sprintf("insert into `vansu` (`date`,`content`) values ('%s', '%s')", day, content)
			log.Info(query)
			_, err = sqldb.Exec(query)
			if err != nil {
				log.Error("%v", err)
				return
			}
		}
	}
}
