package main

import (
	"bytes"
	"crypto/md5"
	"crypto/sha256"
	"crypto/tls"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
	"os"
	log "phongthuy/utilities/logging"
	"strings"
	"time"

	"github.com/BurntSushi/toml"
	"github.com/gin-gonic/gin"
)

type ServerConf struct {
	Binding string `toml:"bind"`
}

type MiscConf struct {
	RedirectTime int64  `toml:"redirect_time"`
	AdapterURL   string `toml:"adapter_url"`
}

type BGConf struct {
	Server ServerConf `toml:"server"`
	Misc   MiscConf   `toml:"misc"`
}

var (
	conf BGConf
)

const (
	CALLBACK                      = `/callback_authentication`
	SPID                          = `001011`
	CPID                          = `001011`
	USERNAME                      = `phongthuynguhanh`
	PASSWORD                      = `phongthuy@123p`
	ERROR_CONGTT_SUCCESSFUL       = "WCG-0000"
	ERROR_CONGTT_UNREG_SUCCESSFUL = "WCG-0024"
	LAYOUT                        = "2006-01-02 15:04:01" // phai la 2006-01-02, ko duoc 2006-02-01
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
	spid := ctx.DefaultQuery("spid", "")
	cpid := ctx.DefaultQuery("cpid", "")
	transaction_id := ctx.DefaultQuery("transaction_id", "")
	msisdn := ctx.DefaultQuery("msisdn", "")
	pkg_code := ctx.DefaultQuery("pkg_code", "")
	price := ctx.DefaultQuery("price", "0")
	resultCode := ctx.DefaultQuery("resultCode", "")
	shortcode := ctx.DefaultQuery("shortcode", "")
	hashstring := ctx.DefaultQuery("hashstring", "")
	callback_type := ctx.DefaultQuery("type", "")
	day_circle := ctx.DefaultQuery("day_circle", "")

	//	log.Info("hashstring from cong CP %s", hashstring)

	//check toan ven du lieu
	inEncode := spid + cpid + transaction_id + pkg_code + callback_type + shortcode + msisdn + price + day_circle + resultCode + USERNAME + GenerateMd5(GenerateMd5(PASSWORD))
	inEncode = fmt.Sprintf("%s%d", inEncode, len(inEncode))
	//	log.Info("inEnCode %s", inEncode)
	//	log.Info("hashstring gen from CP %s", GenerateSHA256(inEncode))
	if hashstring != GenerateSHA256(inEncode) {
		return
	}
	//log all
	log.Info("spid %s cpid %s transaction_id %v pkg_code %s type %s shortcode %s msisdn %s price %s day_circle %s resultCode %s", spid, cpid, transaction_id, pkg_code, callback_type, shortcode, msisdn, price, day_circle, resultCode)
	if strings.HasPrefix(msisdn, "0") {
		msisdn = strings.Replace(msisdn, string(msisdn[0]), "84", 1)
	}
	// check type is register or unregister
	msg_type := ""
	sms_content := ""
	interaction := ""
	if callback_type == "0" {
		interaction = "recevie_un_register_sub"
		sms_content = "hủy trên website http://phongthuynguhanh.com.vn"
		msg_type = EMessageType["USER_UNREGISTER"]
		//check status code
		if resultCode == ERROR_CONGTT_UNREG_SUCCESSFUL {
			//TODO send password
			send_mt := RegisterMsg{
				Interaction:   interaction,
				Msisdn:        msisdn,
				TimeStamp:     time.Now().Format(LAYOUT),
				ServiceCode:   "PTNH",
				SubCode:       strings.Trim(pkg_code, " "),
				ShortCode:     shortcode,
				SmsMO:         fmt.Sprintf("Huy gói cước %s", pkg_code),
				Price:         price,
				SmsMT:         sms_content,
				Source:        "WEB",
				TransactionID: transaction_id,
				ErrorCode:     resultCode,
				Type:          msg_type,
			}

			raw, _ := json.Marshal(send_mt)
			_, err := post(conf.Misc.AdapterURL, raw)
			if err != nil {
				log.Error("%v", err)
				return
			}
			//POST to application
			log.Info("POST to Application OK")

		}
	} else {
		interaction = "recevie_register_sub"
		sms_content = "ĐK trên website http://phongthuynguhanh.com.vn"
		msg_type = EMessageType["USER_REGISTER"]
		//check status code
		if resultCode == ERROR_CONGTT_SUCCESSFUL {
			//TODO send password
			send_mt := RegisterMsg{
				Interaction:   interaction,
				Msisdn:        msisdn,
				TimeStamp:     time.Now().Format(LAYOUT),
				ServiceCode:   "PTNH",
				SubCode:       strings.Trim(pkg_code, " "),
				ShortCode:     shortcode,
				SmsMO:         fmt.Sprintf("dk gói cước %s", pkg_code),
				Price:         price,
				SmsMT:         sms_content,
				Source:        "WEB",
				TransactionID: transaction_id,
				ErrorCode:     resultCode,
				Type:          msg_type,
			}

			raw, _ := json.Marshal(send_mt)
			_, err := post(conf.Misc.AdapterURL, raw)
			if err != nil {
				log.Error("%v", err)
				return
			}
			//POST to application
			log.Info("POST to Application OK")

		}
	}

	if callback_type == "0" {
		//information for un_reg
		if resultCode == ERROR_CONGTT_SUCCESSFUL {
			ctx.Redirect(http.StatusMovedPermanently, "http://phongthuynguhanh.com.vn/unreg_successful.html")
			return
		}
		if resultCode == ERROR_CONGTT_UNREG_SUCCESSFUL {
			ctx.Redirect(http.StatusMovedPermanently, "http://phongthuynguhanh.com.vn/unreg_successful.html")
			return
		}
		ctx.Redirect(http.StatusMovedPermanently, "http://phongthuynguhanh.com.vn/unreg_unsuccessful.html")
		return
	} else {
		if resultCode == ERROR_CONGTT_SUCCESSFUL {
			ctx.Redirect(http.StatusMovedPermanently, "http://phongthuynguhanh.com.vn/successful.html")
			return
		} else if resultCode == "WCG-0021" {
			ctx.Redirect(http.StatusMovedPermanently, "http://phongthuynguhanh.com.vn/register_denied.html")
			return
		} else if resultCode == "WCG-0026" {
			ctx.Redirect(http.StatusMovedPermanently, "http://phongthuynguhanh.com.vn/register_duplicated.html")
			return
		}
		ctx.Redirect(http.StatusMovedPermanently, "http://phongthuynguhanh.com.vn/unsuccessful.html")
		return
	}

}

func main() {

	//go-gin
	g := gin.Default()
	g.GET(CALLBACK, CallBack_Handler)
	g.Run(conf.Server.Binding)
	log.Info("go-gin server start...")

}
