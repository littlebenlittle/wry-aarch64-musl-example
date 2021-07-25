#!/bin/bash

if [ -z "$LOCAL" ]; then echo "please set LOCAL"; exit 1; fi

if [ ! -d "$LOCAL/aarch64-linux-musl-cross" ]; then
	set -e
	musl_cc='https://musl.cc/aarch64-linux-musl-cross.tgz'
	pushd $LOCAL 
		tar=aarch64-linux-musl-cross.tgz
		wget -O $tar $musl_cc
		trap "rm $tar" EXIT
		tar -xf $tar
	popd
	unset -e
fi

podman image ls | grep 'rs' | grep 'webkit-base' >/dev/null
if [ -z $? ]; then
	echo 'building rs:webkit-base'
	set -e
	ctr=`buildah from docker.io/library/rust:1.53-alpine3.13`
	trap "buildah rm $ctr" EXIT
	buildah run $ctr apk add \
		gtk+3.0 \
		webkit2gtk-dev \
		gtksourceview-dev \
		glib-dev
	buildah commit $ctr 'rs:webkit-base'
fi

echo 'building rs:webkit-aarch64'
set -e
ctr=`buildah from rs:webkit-base`
trap "buildah rm $ctr" EXIT
buildah run $ctr rustup target add aarch64-unknown-linux-musl
buildah commit $ctr rs:webkit-aarch64
