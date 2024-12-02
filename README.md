# pgrx on wasi POC

## Get the wasi sdk modified version

- Option 1: `git clone https://github.com/pygame-web/python-wasi-sdk.git` then run `./python-wasi-sdk.sh` to build from source (see readme of pglite-build)

- Option 2 (Ubuntu am64 only): run `./wasi-sdk.sh` which directly downloads the compiled sdk.

## Building pglite

- `git clone https://github.com/electric-sql/pglite-build.git`
- export SDKROOT=${SDKROOT:-/opt/python-wasm-sdk}
- ./wasisdk.sh

## Build the extension

```sh
./build.sh
```
