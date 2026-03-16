#!/bin/bash

# Copyright (c) 2026 Vlad
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

echo -e '\n🟩 Installing NotFound...\n'

mkdir -p /usr/local/bin
mkdir -p /usr/local/share/nofound
mkdir -p /usr/local/lib/systemd/system

wget -O notfound-linux-amd64.tar.gz https://github.com/vldrus/notfound/releases/download/v1.0.0/notfound-linux-amd64.tar.gz
echo 'b47b1d7c68da6f5f29464c8e2e7291e8e7e33dda761255a009dca97223de0e0f *notfound-linux-amd64.tar.gz' | sha256sum -c

tar -x -C /usr/local -f notfound-linux-amd64.tar.gz

rm notfound-linux-amd64.tar.gz

systemctl enable notfound.service
systemctl start notfound.service

echo -e '\n🟩 Installing NotFound DONE\n'
