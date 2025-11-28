#!/bin/bash

echo -e '\n🟩 Installing NotFound...\n'

wget -O notfound.tar.gz https://github.com/vldrus/notfound/releases/download/v1.0.2/notfound-linux-amd64.tar.gz
echo '0212ba3996c797de77e5bb255ec533ebf28327f2011abda6d30b68e11a346677 *notfound.tar.gz' | sha256sum -c
tar -x -C /opt -f notfound.tar.gz
rm notfound.tar.gz

cp /opt/notfound/notfound.service /etc/systemd/system/notfound.service

systemctl enable notfound
systemctl start notfound

echo -e '\n🟩 Installing NotFound DONE\n'
