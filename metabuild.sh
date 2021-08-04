#!/bin/bash

set -e

ctr=`buildah from rustembedded/cross:aarch64-unknown-linux-musl-0.2.1`
trap "buildah rm $ctr" EXIT

buildah run $ctr apt-get update
buildah run $ctr apt-get install -y \
	libwebkit2gtk-4.0-dev \
	libgtksourceviewmm-3.0-dev \
	libc6-dev-i386 \
	clang
buildah commit $ctr cross-wry:aarch64-unknown-linux-musl-0.2.1
