#!/usr/bin/env sh
DIR=~/Downloads
MIRROR=https://github.com/projectcalico/calicoctl/releases/download

dl()
{
    local ver=$1
    local os=$2
    local arch=$3
    local suffix=${4:-}
    local url=$MIRROR/$ver/calicoctl-$os-$arch$suffix
    local lfile=$DIR/calicoctl-$os-$arch-$ver$suffix

    if [ ! -e $lfile ];
    then
        wget -q -O $lfile $url
    fi

    printf "    # %s\n" $url
    printf "    %s-%s: sha256:%s\n" $os $arch `sha256sum $lfile | awk '{print $1}'`
}

dl_ver() {
    local ver=$1
    printf "  %s:\n" $ver
    dl $ver darwin amd64
    dl $ver linux amd64
    dl $ver linux arm64
    dl $ver linux ppc64le
    dl $ver windows amd64 .exe
}

dl_ver ${1:-v3.20.1}
