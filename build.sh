#!/bin/bash

cmd="cargo build --target=aarch64-unknown-linux-musl $@"

podman run -ti --rm \
	--name rs \
	-v ./:/mnt \
	-w /mnt \
	-e PKG_CONFIG_ALLOW_CROSS=1 \
	rs:webkit-aarch64 $cmd
