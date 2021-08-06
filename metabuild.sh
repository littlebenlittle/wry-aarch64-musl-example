#!/bin/bash

set -e

ctr=`buildah from rustembedded/cross:aarch64-unknown-linux-musl-0.2.1`
trap "buildah rm $ctr" EXIT

buildah run $ctr apt-get update
buildah run $ctr dpkg --add-architecture i386
buildah run $ctr apt-get install -y \
	libwebkit2gtk-4.0-dev:i386 \
	libgtksourceviewmm-3.0-dev:i386
buildah commit $ctr cross-wry:webkit
buildah commit $ctr cross-wry
