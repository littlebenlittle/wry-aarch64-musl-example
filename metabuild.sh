#!/bin/bash

set -e

arch=armhf

ctr=`buildah from rustembedded/cross:aarch64-unknown-linux-musl-0.2.1`
trap "buildah rm $ctr" EXIT

buildah run $ctr dpkg --add-architecture $arch
buildah run $ctr apt-get update
buildah run $ctr apt-get install -y \
	libwebkit2gtk-4.0-dev:$arch \
	libgtksourceview-3.0-dev:$arch
buildah commit $ctr cross-wry:$arch
