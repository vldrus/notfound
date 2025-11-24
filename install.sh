#!/bin/bash

echo -e '\n🟩 INSTALLING NOTFOUND...\n'

wget -O notfound.tar.gz https://github.com/vldrus/notfound/releases/download/v1.0.1/notfound-linux-amd64.tar.gz
echo '2365b31f0b0ccfef70baf7f36f3309b5033d4a9a *notfound.tar.gz' | sha1sum -c
tar -x -C /opt -f notfound.tar.gz
rm notfound.tar.gz

mv /opt/notfound/notfound.service /etc/systemd/system/notfound.service

systemctl enable notfound
systemctl start notfound

echo -e '\n🟩 DONE\n'
