# pgrx on wasi POC

## Prerequisites

For compiler host: A debian-like distro, amd64 arch.

**For pgrx**

`sudo apt-get install build-essential libreadline-dev zlib1g-dev flex bison libxml2-dev libxslt-dev libssl-dev libxml2-utils xsltproc ccache pkg-config`

**Other**

wasmtime: `curl https://wasmtime.dev/install.sh -sSf | bash`

`sudo apt-get install clang libc++-14-dev wget pv lz4 emscripten`


## Get the wasi sdk modified version

- Option 1: `git clone https://github.com/pygame-web/python-wasi-sdk.git` then run `./python-wasi-sdk.sh` to build from source (see readme of pglite-build)

- Option 2 (Ubuntu amd64 only): run `./wasi-sdk.sh` which directly downloads the compiled sdk.

## Building pglite

- `git clone https://github.com/electric-sql/pglite-build.git`
- `export SDKROOT=/opt/python-wasm-sdk`
- `export PATH="$SDKROOT/wasisdk/bin:$PATH"`
- `./wasisdk.sh`

## Prepare the rust toolchain

- Install rust toolchain: `make rust_addons`
- Pull and init `pgrx-wasi` workspace: `make init_pgrx`

## Build the extension

- Build host: `make build_ext_host`
- Build the extension: `make build_ext`