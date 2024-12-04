#!/bin/bash

SDKROOT=/opt/python-wasm-sdk

export WASI_SDK_PATH="$SDKROOT/wasisdk/upstream"

# set pg_config (wrapper) path
echo '/opt/python-wasm-sdk/wasisdk/bin/wasi-run /tmp/pglite/bin/pg_config.wasi "$@"' > /tmp/pglite/bin/pg_config
export PATH="/tmp/pglite/bin:$PATH"

# pgrx bindgen flags
export PGRX_PG_CONFIG_PATH=/tmp/pglite/bin/pg_config_wrapper
export PGRX_BINDGEN_NO_DETECT_INCLUDES=1

export BINDGEN_EXTRA_CLANG_ARGS_wasm32_wasip1="-isystem $WASI_SDK_PATH/share/wasi-sysroot/include"
# export RUSTFLAGS="--sysroot $WASI_SDK_PATH/share/wasi-sysroot"
# export CC=$WASI_SDK_PATH/bin/clang 
# export CXX=$WASI_SDK_PATH/bin/clang++
# export CXXFLAGS="-fno-exceptions"

. $SDKROOT/wasm32-wasi-shell.sh
. $SDKROOT/${CONFIG:-config}

echo "building the extension pgrx-wasi/pgrx-examples/$1"
pushd pgrx-wasi/pgrx-examples/$1

cargo +nightly build --target wasm32-wasip1 --sysroot "$WASI_SDK_PATH/share/wasi-sysroot" \
           --lib --features pg16,pgrx/cshim --no-default-features

popd