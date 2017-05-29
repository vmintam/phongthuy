package main

import (
	"bufio"
	"bytes"
	"crypto/tls"
	"encoding/json"
	"net/smtp"
	//	"fmt"
	"io/ioutil"
	"net/http"
	"net/url"
	"os"
	log "phongthuy/utilities/logging"
	"strings"
	"time"
)

type User struct {
	FirstName string
	LastName  string
	Status    string
	Email     string
	Password  string
	Roles     string
}

const (
	API_CREATE_USER = `http://cskh.phongthuynguhanh.com.vn//api/saveuser.html`
)

func post(url string, data *bytes.Buffer) (body []byte, err error) {
	log.Info("URL %s", url)
	tr := &http.Transport{
		TLSClientConfig: &tls.Config{InsecureSkipVerify: true},
	}
	timeout := time.Duration(30 * time.Second)
	client := &http.Client{
		Timeout:   timeout,
		Transport: tr,
	}
	r, _ := http.NewRequest("POST", url, data) // <-- URL-encoded payload
	r.Header.Add("Content-Type", "application/x-www-form-urlencoded")

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

type Response struct {
	Error json.Number `json:"err,Number"`
	Msg   string      `json:"msg"`
}

func CreateUser(user User) (resp Response) {
	create_user := url.Values{}
	create_user.Set("first_name", user.FirstName)
	create_user.Add("last_name", user.LastName)
	create_user.Add("status", "1")
	create_user.Add("email", user.Email)
	create_user.Add("password", user.Password)
	create_user.Add("roles", user.Roles)
	log.Info("POST with data email %s, password %s ", user.Email, user.Password)
	body, err := post(API_CREATE_USER, bytes.NewBufferString(create_user.Encode()))
	if err != nil {
		log.Error("%v", err)
		return
	}
	//decode response
	err = json.Unmarshal(body, &resp)
	log.Info("resp from API %s", string(body))
	return resp
}

func send() {
	// Set up authentication information.
	auth := smtp.PlainAuth(
		"",
		"user@example.com",
		"password",
		"mail.example.com",
	)
	// Connect to the server, authenticate, set the sender and recipient,
	// and send the email all in one step.
	err := smtp.SendMail(
		"mail.example.com:25",
		auth,
		"sender@example.org",
		[]string{"recipient@example.net"},
		[]byte("This is the email body."),
	)
	if err != nil {
		log.Fatal(err)
	}
}

func main() {

	// open a file
	if file, err := os.Open("tb_read.txt"); err == nil {

		// make sure it gets closed
		defer file.Close()
		user := User{}
		// create a new scanner and read the file line by line
		scanner := bufio.NewScanner(file)
		for scanner.Scan() {
			line := scanner.Text()
			user.FirstName = strings.Split(line, "######")[0]
			user.LastName = strings.Split(line, "######")[1]
			user.Status = strings.Split(line, "######")[2]
			user.Email = strings.Split(line, "######")[3]
			user.Password = strings.Split(line, "######")[4]
			user.Roles = "cskh_roles_read_only"
			resp := CreateUser(user)
			log.Info("%v", resp)
		}
		// check for errors
		if err = scanner.Err(); err != nil {
			log.Error("%v", err)
		}

	} else {
		log.Error("%v", err)
	}
}
