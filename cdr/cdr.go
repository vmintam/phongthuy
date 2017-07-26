package main

import (
	"database/sql"
	"os"
	log "phongthuy/utilities/logging"
	//	"strings"

	"github.com/BurntSushi/toml"
	"github.com/jlaffaye/ftp"
)

type MiscConf struct {
	CONGTT_FTP      string `toml:"congtt_ftp"`
	CONGTT_USERNAME string `toml:"congtt_username"`
	CONGTT_PASSWORD string `toml:"congtt_password"`

	CDR_FTP      string `toml:"cdr_ftp"`
	CDR_USERNAME string `toml:"cdr_username"`
	CDR_PASSWORD string `toml:"cdr_password"`
}

type BGConf struct {
	Misc MiscConf `toml:"misc"`
}

var (
	conf  BGConf
	sqldb *sql.DB
)

const (
	LAYOUT_FPT = "20060102"
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
	// this line define error below is very important

}

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func main() {
	client, err := ftp.Dial(conf.Misc.CONGTT_FTP)
	if err != nil {
		log.Error("%v", err)
		os.Exit(2)
	}

	if err := client.Login(conf.Misc.CONGTT_USERNAME, conf.Misc.CONGTT_PASSWORD); err != nil {
		log.Error("%v", err)
		os.Exit(2)
	}

	// entries, _ := client.List(time.Now().Format(LAYOUT_FPT))
	entries, _ := client.List("log4php")
	for _, entry := range entries {
		log.Info("name %s time %d type %d", entry.Name, entry.Time.Unix(), entry.Type)
		name := entry.Name
		if entry.Type == ftp.EntryTypeFile {
			client.ChangeDir("log4php")
			_, err := client.Retr(name)
			if err != nil {
				panic(err)
			}
		}

		// client.Delete(name)
	}
}
