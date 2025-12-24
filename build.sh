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

rm -f notfound
rm -f notfound-linux-amd64.tar.gz

mkdir -p bin
mkdir -p lib/systemd/system
mkdir -p share/notfound

chmod 755 bin
chmod 755 lib lib/systemd lib/systemd/system
chmod 755 share share/notfound

CGO_ENABLED=0 go build -ldflags="-s -w -X 'main.GoVersion=$(go version)'"

cp notfound         bin
cp notfound.service lib/systemd/system
cp LICENSE          share/notfound

chmod 755 bin/notfound
chmod 644 lib/systemd/system/notfound.service
chmod 644 share/notfound/LICENSE

tar -c -z -f notfound-linux-amd64.tar.gz bin lib share

rm -rf bin
rm -rf lib
rm -rf share
