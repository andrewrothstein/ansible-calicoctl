#!/usr/bin/env sh

set -e

DIR=~/Downloads
MIRROR=https://github.com/projectcalico/calico/releases/download

# https://github.com/projectcalico/calico/releases/download/v3.23.2/calicoctl-darwin-amd64

dl()
{
    local ver=$1
    local os=$2
    local arch=$3
    local suffix=${4:-}
    local url=$MIRROR/v$ver/calicoctl-$os-$arch$suffix
    local lfile=$DIR/calicoctl-$os-$arch-$ver$suffix

    if [ ! -e $lfile ];
    then
        curl -sSL -f -o $lfile $url
    fi

    printf "    # %s\n" $url
    printf "    %s-%s: sha256:%s\n" $os $arch `sha256sum $lfile | awk '{print $1}'`
}

dl_ver() {
    local ver=$1
    printf "  '%s':\n" $ver
    dl $ver darwin amd64
    dl $ver darwin arm64
    dl $ver linux amd64
    dl $ver linux arm64
    dl $ver linux armv7
    dl $ver linux ppc64le
    dl $ver linux s390x
    dl $ver windows amd64 .exe
}

dl_ver ${1:-3.24.0}
