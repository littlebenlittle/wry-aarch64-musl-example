out=$(CURDIR)/target/debug/app
rsync_warning=please set REMOTE_DIR ( hint: source .env )

build: metabuild
	cargo build --target aarch64-unknown-linux-musl

rsync:
	@if [ -z "$$REMOTE_DIR" ]; then echo "$(rsync_warning)"; else rsync -vv "$(out)" "$$REMOTE_DIR"; fi
