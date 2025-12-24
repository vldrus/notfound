#!/bin/bash

echo -e '\n🟩 Installing NotFound...\n'

mkdir -p /usr/local/bin
mkdir -p /usr/local/lib/systemd/system

wget -O notfound-linux-amd64.tar.gz https://github.com/vldrus/notfound/releases/download/v1.0.0/notfound-linux-amd64.tar.gz
echo 'f677eb1980ad6c30f3a5547abfec3b93d87c09788689d061f39005b1237285e8 *notfound-linux-amd64.tar.gz' | sha256sum -c

tar -x -C /usr/local -f notfound-linux-amd64.tar.gz

rm notfound-linux-amd64.tar.gz

systemctl enable notfound.service
systemctl start notfound.service

echo -e '\n🟩 Installing NotFound DONE\n'
