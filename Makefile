SHELL=/bin/bash
out=$(CURDIR)/target/aarch64-unknown-linux-musl/debug/hi-wo

build:
	cargo build --target=aarch64-unknown-linux-musl

build-local:
	cargo build

rsync:
	@if [ -z "$$REMOTE_DIR" ]; then echo "please set REMOTE_DIR ( hint: source .env )"; else rsync -vv "$(out)" "$$REMOTE_DIR"; fi
