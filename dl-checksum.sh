#!/usr/bin/env sh
VER=v3.6.3
DIR=~/Downloads
MIRROR=https://github.com/projectcalico/calicoctl/releases/download/$VER

dl()
{
    OS=$1
    PLATFORM=$2
    SUFFIX=${3:-}
    URL=$MIRROR/calicoctl-$OS-$PLATFORM$SUFFIX
    LFILE=$DIR/calicoctl-$OS-$PLATFORM-$VER$SUFFIX

    if [ ! -e $LFILE ];
    then
        wget -q -O $LFILE $URL
    fi

    printf "  # %s\n" $URL
    printf "  %s-%s: sha256:%s\n" $OS $PLATFORM `sha256sum $LFILE | awk '{print $1}'`
}

printf "%s:\n" $VER
dl darwin amd64
dl linux amd64
dl linux arm64
dl linux ppc64le
dl windows amd64 .exe


