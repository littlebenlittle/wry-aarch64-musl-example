SHELL=/bin/bash
out=$(CURDIR)/target/aarch64-unknown-linux-musl/release/test
local=$(CURDIR)/.local
metabuild=$(CURDIR)/metabuild.sh
rsync_warning=please set REMOTE_DIR ( hint: source .env )
metabuild_hash=$(local)/metabuild.sha1

debug: metabuild
	$(CURDIR)/build.sh --verbose

release: metabuild
	$(CURDIR)/build.sh --release --verbose

metabuild:
	@if [ ! -d "$(local)" ]; then mkdir $(local); fi
	@touch $(metabuild_hash)
	@if [ ! -z "`diff <(sha1sum $(metabuild)) $(metabuild_hash)`" ]; then \
	    LOCAL=$(local) $(metabuild) || exit 1; \
		sha1sum $(metabuild) > $(metabuild_hash); \
	fi

rsync:
	@if [ -z "$$REMOTE_DIR" ]; then echo "$(rsync_warning)"; else rsync -vv "$(out)" "$$REMOTE_DIR"; fi
