#!/bin/bash

echo -e '\n🟩 Installing NotFound...\n'

mkdir -p /usr/local/bin
mkdir -p /usr/local/lib/systemd/system

wget -O notfound-linux-amd64.tar.gz https://github.com/vldrus/notfound/releases/download/v1.0.0/notfound-linux-amd64.tar.gz
echo '7bf0f0ace05b3891afb82b73a1c14af691dcb63e31416bf46f39c439ca468ca1 *notfound-linux-amd64.tar.gz' | sha256sum -c

tar -x -C /usr/local -f notfound-linux-amd64.tar.gz

rm notfound-linux-amd64.tar.gz

systemctl enable notfound.service
systemctl start notfound.service

echo -e '\n🟩 Installing NotFound DONE\n'
