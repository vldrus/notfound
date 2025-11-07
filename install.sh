#!/bin/bash

echo -e '\n🟩 INSTALLING NOTFOUND...\n'

wget -O notfound.tar.gz https://github.com/vldrus/notfound/releases/download/v1.0.0/notfound-linux-amd64.tar.gz

echo '82b067fb9c62288b21a81ce7b5d4fedee04a2fca *notfound.tar.gz' | sha1sum -c

tar -x -C /opt -f notfound.tar.gz && rm notfound.tar.gz

ln -s /opt/notfound/notfound.service /etc/systemd/system/notfound.service

systemctl enable notfound
systemctl start notfound

echo -e '\n🟩 DONE\n'
