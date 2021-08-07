#!/bin/bash

cmd="xargo build --target=aarch64-unknown-linux-musl $@"

podman run -ti --rm \
	--name rs \
	-v ./:/mnt \
	-w /mnt \
	-e RUST_BACKTRACE=1 \
	localhost/webkit-aarch64 $cmd
	# -e CC_aarch64_unknown_linux_musl=/opt/aarch64-linux-musl-cross/bin/aarch64-linux-musl-gcc \
	# -e CXX_aarch64_unknown_linux_musl=/opt/aarch64-linux-musl-cross/bin/aarch64-linux-musl-g++ \
	# -e QEMU_LD_PREFIX=/opt/aarch64-linux-musl-cross \
	# -e PKG_CONFIG_PATH=/opt/aarch64-linux-musl-cross/lib \
	# -e PKG_CONFIG_ALLOW_CROSS=1 \
