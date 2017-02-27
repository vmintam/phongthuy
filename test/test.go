package main

import (
	"fmt"

	"github.com/headzoo/surf"
)

func main() {
	bow := surf.NewBrowser()
	//	bow.SetUserAgent(agent.Chrome())
	bow.SetAttribute(browser.SendReferer, true)
	bow.SetAttribute(browser.MetaRefreshHandling, true)
	bow.SetAttribute(browser.FollowRedirects, true)
	bow.AddRequestHeader("msisdn", "84936315768")
	url := `http://phongthuynguhanh.com.vn/site/register.html`
	err := bow.Open(url)
	if err != nil {
		panic(err)
	}
	thing := bow.Find(".action")
	for iThing := range thing.Nodes {
		singlething := thing.Eq(iThing)
		fmt.Println(singlething.Html())
		err := bow.Click("a")
		if err != nil {
			panic(err)
		}
		break
	}
}
