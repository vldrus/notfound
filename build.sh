#!/usr/bin/env bash

GO_VERSION=1.27.4
GO_SHA256_SUM=7226736c2339719cda28fbf3a54d71aa63bcefe376e98cef00034268dab24840

umask 022

wget -q -O go$GO_VERSION.linux-amd64.tar.gz https://go.dev/dl/go$GO_VERSION.linux-amd64.tar.gz
echo "$GO_SHA256_SUM *go$GO_VERSION.linux-amd64.tar.gz" | sha256sum -c || exit $?
tar -x --no-same-owner -f go$GO_VERSION.linux-amd64.tar.gz
rm go$GO_VERSION.linux-amd64.tar.gz

GOROOT="$PWD/go"
GOPATH="$PWD/gopath"

rm -f notfound
rm -f notfound-linux-amd64.tar.gz

mkdir -p bin
mkdir -p lib/systemd/system
mkdir -p share/notfound

CGO_ENABLED=0 GOOS=linux GOARCH=amd64 "$GOROOT/bin/go" build -ldflags="-s -w"

cp notfound         bin
cp notfound.service lib/systemd/system
cp LICENSE          share/notfound

tar -c -z -f notfound-linux-amd64.tar.gz bin lib share

rm -rf bin
rm -rf lib
rm -rf share
