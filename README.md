##  build wasi sdk modified version

- git clone https://github.com/pygame-web/python-wasi-sdk.git then run ./python-wasi-sdk.sh to build (see readme of pglite-build)

##  Building pglite

- clone https://github.com/electric-sql/pglite-build.git
- export SDKROOT=${SDKROOT:-/opt/python-wasm-sdk}
- ./wasisdk.sh

## Build the extension:
```sh
./build.sh
```

