package main

import (
	"crypto/tls"
	"flag"
	"log"
	"net/http"
	"os"
	"os/signal"
	"sync/atomic"
	"syscall"
	"time"
)

func main() {
	addr := flag.String("addr", "0.0.0.0:8888", "")

	certFile := flag.String("cert", "/usr/local/share/cert/cert.crt", "")
	keyFile  := flag.String("key",  "/usr/local/share/cert/cert.key", "")

	flag.Parse()

	var certStore atomic.Pointer[tls.Certificate]

	cert, err := tls.LoadX509KeyPair(*certFile, *keyFile)
	if err != nil {
		log.Fatalln("Error", err)
	}
	certStore.Store(&cert)

	signals := make(chan os.Signal, 1)
	signal.Notify(signals, syscall.SIGHUP)

	go func() {
		for {
			sig := <-signals

			if sig == syscall.SIGHUP {
				cert, err := tls.LoadX509KeyPair(*certFile, *keyFile)
				if err != nil {
					log.Println("Error", err)
					continue
				}
				certStore.Store(&cert)

				log.Println("Certificate updated")
			}
		}
	}()

	server := http.Server{
		ReadTimeout:  5 * time.Second,
		WriteTimeout: 10 * time.Second,
		IdleTimeout:  120 * time.Second,

		TLSConfig: &tls.Config{
			GetCertificate: func(chi *tls.ClientHelloInfo) (*tls.Certificate, error) {
				return certStore.Load(), nil
			},
		},

		Addr: *addr,

		Handler: http.NotFoundHandler(),
	}

	log.Println("Listening on", *addr, "with", *certFile, "and", *keyFile)

	err = server.ListenAndServeTLS("", "")
	if err != nil {
		log.Fatalln("Error", err)
	}
}
