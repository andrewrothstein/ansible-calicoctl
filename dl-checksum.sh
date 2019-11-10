#!/usr/bin/env sh
VER=${1:-v3.10.1}
DIR=~/Downloads
MIRROR=https://github.com/projectcalico/calicoctl/releases/download/$VER

dl()
{
    local os=$1
    local arch=$2
    local suffix=${3:-}
    local url=$MIRROR/calicoctl-$os-$arch$suffix
    local lfile=$DIR/calicoctl-$os-$arch-$VER$suffix

    if [ ! -e $lfile ];
    then
        wget -q -O $lfile $url
    fi

    printf "    # %s\n" $url
    printf "    %s-%s: sha256:%s\n" $os $arch `sha256sum $lfile | awk '{print $1}'`
}

printf "  %s:\n" $VER
dl darwin amd64
dl linux amd64
dl linux arm64
dl linux ppc64le
dl windows amd64 .exe


