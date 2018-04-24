package main

import (
	"fmt"
	"os"

	"github.com/armon/go-socks5"
)

func check(err error) {
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}

func main() {
	conf := &socks5.Config{Credentials: socks5.StaticCredentials{os.Getenv("PROXY_USER"): os.Getenv("PROXY_PASSWORD")}}
	server, err := socks5.New(conf)
	check(err)

	err = server.ListenAndServe("tcp", os.Getenv("PROXY_ADDR")+":8000")
	check(err)
}
