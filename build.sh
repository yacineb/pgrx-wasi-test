SDKROOT=/opt/python-wasm-sdk

export WASI_SDK_PATH="$SDKROOT/wasisdk/upstream"

echo '/opt/python-wasm-sdk/wasisdk/bin/wasi-run /tmp/pglite/bin/pg_config "$@"' > /tmp/pglite/bin/pg_config

export PATH="/tmp/pglite/bin/:$SDKROOT/wasisdk/bin:$PATH"

export BINDGEN_EXTRA_CLANG_ARGS_wasm32_wasip1="-isystem $WASI_SDK_PATH/share/wasi-sysroot/include"
# export RUSTFLAGS="--sysroot $WASI_SDK_PATH/share/wasi-sysroot"
# export CC=$WASI_SDK_PATH/bin/clang 
# export CXX=$WASI_SDK_PATH/bin/clang++
# export CXXFLAGS="-fno-exceptions"
# export PGRX_BINDGEN_NO_DETECT_INCLUDES=1

. $SDKROOT/wasm32-wasi-shell.sh

echo "set up rust toolchain"
pushd ${SDKROOT}
    . ${CONFIG:-config}
    . wasm32-bi-emscripten-shell.sh
popd

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > getrust
bash ./getrust -y -t wasm32-unknown-unknown --default-toolchain nightly

. $SDKROOT/rust/env


rustup target add wasm32-unknown-unknown
rustup target add wasm32-unknown-emscripten
rustup target add wasm32-wasip1

echo building the extension
cargo +nightly build  --target wasm32-wasip1 --sysroot "$SDKROOT/wasisdk/upstream/share/wasi-sysroot" \
           --lib --features pg16,pgrx/cshim --no-default-features