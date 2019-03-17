#!/usr/bin/env sh
VER=v3.2.6
DIR=~/Downloads
MIRROR=https://github.com/projectcalico/calicoctl/releases/download/$VER

for PLATFORM in darwin-amd64 linux-amd64 linux-arm64 linux-ppc64le windows-amd64.exe
do
    wget -O $DIR/calicoctl-$PLATFORM-$VER $MIRROR/calicoctl-$PLATFORM
done
sha256sum $DIR/calicoctl-*-$VER

