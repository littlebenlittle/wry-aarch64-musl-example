
# Experimental App using WRY on `aarch64`

## Purpose

This app is intended to test `webkit2gtk` on the Pine64 Pinephone running PostmarketOS.

## Dev

Configure connection to remote device:

```sh
cat >.env <<EOF
export REMOTE_HOST=10.0.0.123
export REMOTE_USER=user@\$REMOTE_HOST
export REMOTE_DIR=\$REMOTE_USER:/home/user
EOF
source .env
```

### Build

```sh
make build
```
