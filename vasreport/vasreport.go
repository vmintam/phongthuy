package main

import (
	//	"net/http"
	"database/sql"
	"os"
	log "phongthuy/utilities/logging"
	"strings"

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
	client, err := ftp.Connect("45.32.110.39:21")
	if err != nil {
		panic(err)
	}
	defer client.Quit()

	err = client.Login("bachbenh", "sjgkdfjg233f")
	if err != nil {
		panic(err)
	}
	test := "day la line 1\n"
	test = test + "day la line 2\n"
	err = client.Stor("save.jpg", strings.NewReader(test))
	if err != nil {
		panic(err)
	}
}
