#!/bin/bash

echo -e '\n🟩 Installing NotFound...\n'

mkdir -p /usr/local/bin
mkdir -p /usr/local/lib/systemd/system

wget -O notfound.tar.gz https://github.com/vldrus/notfound/releases/download/v1.0.2/notfound-linux-amd64.tar.gz
echo '0212ba3996c797de77e5bb255ec533ebf28327f2011abda6d30b68e11a346677 *notfound.tar.gz' | sha256sum -c

tar -x -C /usr/local/bin                -f notfound.tar.gz --strip-components=1 notfound/notfound
tar -x -C /usr/local/lib/systemd/system -f notfound.tar.gz --strip-components=1 notfound/notfound.service

rm notfound.tar.gz

systemctl enable notfound.service
systemctl start  notfound.service

echo -e '\n🟩 Installing NotFound DONE\n'
