- build command

rustup target add wasm32-wasip1
cargo build --target wasm32-wasip1 --lib --features pg13 --no-default-features



Building pglite

- clone https://github.com/electric-sql/pglite-build.git
- export SDKROOT=${SDKROOT:-/opt/python-wasm-sdk}
- ./wasisdk.sh