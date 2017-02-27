package main

import (
	//	"net/http"
	"strings"

	"github.com/jlaffaye/ftp"
)

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
