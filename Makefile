SHELL=/bin/bash
out=$(CURDIR)/target/aarch64-unknown-linux-musl/release/hi-wo

build:
	PKG_CONFIG_ALLOW_CROSS=1 cargo build --target=aarch64-unknown-linux-musl --release

build-local:
	cargo build

rsync:
	@if [ -z "$$REMOTE_DIR" ]; then echo "please set REMOTE_DIR ( hint: source .env )"; else rsync -vv "$(out)" "$$REMOTE_DIR"; fi
