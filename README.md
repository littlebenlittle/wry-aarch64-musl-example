
# Experimental App using WRY on `aarch64`

## Purpose

This app is intended to test `webkit2gtk` on the Pine64 Pinephone running PostmarketOS.

## Dev

### Init

#### Prepare to target `aarch64` `musl`

Get a working cross compiler from [musl.cc](https://musl.cc):

```sh
mkdir .cargo
MUSL=/home/user/musl.cc/aarch64-linux-musl-cross  # or wherever
# based on https://github.com/japaric/xargo/issues/133#issuecomment-681194097
cat >.cargo/config.toml <<EOF
[build]
# Work-around for https://github.com/japaric/xargo/issues/292:
rustflags = ["-Cembed-bitcode=yes"]
[target.aarch64-unknown-linux-musl]
linker = "$MUSL/bin/aarch64-linux-musl-gcc"
# Path to Musl libc.a (plus bitcode work-around)
rustflags = ["-L$MUSL/aarch64-linux-musl/lib", "-Cembed-bitcode=yes"]
EOF
```

Configure connection to remote device:

```sh
cat >.env <<EOF
export REMOTE_HOST=10.0.0.123
export REMOTE_USER=user@\$REMOTE_HOST
export REMOTE_DIR=\$REMOTE_USER:/home/user
EOF
source .env
```

### Build and Run

```sh
make build
make rsync
ssh $REMOTE_USER
./hi-wo
```
