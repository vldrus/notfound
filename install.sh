#!/bin/bash

echo -e '\n🟩 Installing NotFound...\n'

mkdir -p /usr/local/bin
mkdir -p /usr/local/lib/systemd/system

wget -O notfound.tar.gz https://github.com/vldrus/notfound/releases/download/v1.0.3/notfound-linux-amd64.tar.gz
echo '252819dce6c60c6e4928f2c0e207e7cd3212bab76bb3cd3d3e79125e9bba0ed8 *notfound.tar.gz' | sha256sum -c

tar -x -C /usr/local/bin                -f notfound.tar.gz --strip-components=1 notfound/notfound
tar -x -C /usr/local/lib/systemd/system -f notfound.tar.gz --strip-components=1 notfound/notfound.service

rm notfound.tar.gz

systemctl enable notfound.service
systemctl start  notfound.service

echo -e '\n🟩 Installing NotFound DONE\n'
