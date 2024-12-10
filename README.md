# pgrx on wasi POC

## Prerequisites

For compiler host: A debian-like distro, amd64 arch.

**emsdk (emscripten toolchain)**

> Version should be at least: 3.1.73

- `git clone https://github.com/emscripten-core/emsdk.git`
- `cd emsdk`
- `./emsdk install latest`
- `./emsdk activate latest`

Then source the required installation files.

**For pgrx**

`sudo apt-get install build-essential libreadline-dev zlib1g-dev flex bison libxml2-dev libxslt-dev libssl-dev libxml2-utils xsltproc ccache pkg-config`

**Other**

wasmtime: `curl https://wasmtime.dev/install.sh -sSf | bash`

`sudo apt-get install clang libc++-14-dev wget pv lz4`


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

## Docker builds

- 1/ build docker image containing both rust toolchain and emsdk: `docker build . -f Dockerfile.emsdk -t build-test`
- 2/ Then simply use that cli image for building for running any make command in Makefile for example: `docker run  -v $(pwd)/pgrx-wasi:/pgrx-wasi build-test build_ext_host`