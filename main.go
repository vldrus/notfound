/*
Copyright (c) 2026 Vlad

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

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
