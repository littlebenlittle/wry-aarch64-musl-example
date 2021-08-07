#!/bin/bash

set -ex

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

if [ -z "`podman image ls | grep webkit-aarch64 | grep base`" ]; then
	ctr=`buildah from docker.io/library/rust:1.53-alpine3.13`
	trap "buildah rm $ctr" EXIT
	buildah run $ctr apk add \
		gtk+3.0 \
		webkit2gtk-dev \
		gtksourceview-dev
	buildah add $ctr $LOCAL/aarch64-linux-musl-cross /opt/aarch64-linux-musl-cross
	buildah run $ctr rustup target add aarch64-unknown-linux-musl
	buildah run $ctr cargo install xargo
	buildah commit $ctr webkit-aarch64:base
fi

ctr=`buildah from webkit-aarch64:base`
trap "buildah rm $ctr" EXIT
buildah run $ctr rustup default nightly
buildah run $ctr rustup component add rust-src
buildah commit $ctr webkit-aarch64
