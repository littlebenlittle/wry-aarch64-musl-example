#!/bin/bash

set -e

if [ -z "$LOCAL" ]; then echo "please set LOCAL"; exit 1; fi

if [ ! -d "$LOCAL/aarch64-linux-musl-cross" ]; then
	musl_cc='https://musl.cc/aarch64-linux-musl-cross.tgz'
	pushd $LOCAL 
		tar=aarch64-linux-musl-cross.tgz
		wget -O $tar $musl_cc
		trap "rm `pwd`/$tar" EXIT
		tar -xf $tar
	popd
fi

ctr=`buildah from docker.io/library/rust:1.53-alpine3.13`
buildah run $ctr apk add \
    gtk+3.0 \
    webkit2gtk-dev \
    gtksourceview-dev \
    glib-dev
buildah run $ctr rustup target add aarch64-unknown-linux-musl
buildah add $ctr $LOCAL/aarch64-linux-musl-cross /opt/aarch64-linux-musl-cross
buildah commit $ctr rs:webkit-aarch64
