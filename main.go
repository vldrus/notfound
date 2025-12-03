package main

import (
	"flag"
	"log"
	"net/http"
)

func main() {
	addr := flag.String("addr", "localhost:8888", "")
	cert := flag.String("cert", "/usr/local/share/cert/cert.crt" , "")
	key  := flag.String("key" , "/usr/local/share/cert/cert.key" , "")

	flag.Parse()

	log.Println("Listening on", *addr, "with", *cert, "and", *key)

	err := http.ListenAndServeTLS(*addr, *cert, *key, http.NotFoundHandler())
	if err != nil {
		log.Fatalln("Error", err)
	}
}
