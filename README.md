
# Experimental App using WRY on `aarch64`

## Purpose

This app is intended to test `webkit2gtk` on the Pine64 Pinephone running PostmarketOS.

## Dev

### Build

First create an alpine chroot using [`alpine-chroot-install`](https://github.com/alpinelinux/alpine-chroot-install)

```
~/alpine-aarch64-webkit/enter-chroot
apk add rust cargo webkit2gtk-dev rsync
exit
~/alpine-aarch64-webkit/enter-chroot -u user
cargo build
exit
```

### Run

Configure connection to remote device (modify as needed):

```sh
cat >.env <<EOF
export REMOTE_HOST=10.0.0.123
export REMOTE_USER=user@\$REMOTE_HOST
export REMOTE_DIR=\$REMOTE_USER:/home/user
EOF
source .env
make rsync
ssh $REMOTE_USER
./app
```
