#!/bin/bash

# rustc codegen options: https://doc.rust-lang.org/rustc/codegen-options/index.html

export SDKROOT=/opt/python-wasm-sdk

export WASI_SDK_PATH="$SDKROOT/wasisdk/upstream"
export WASI_SYSROOT="$WASI_SDK_PATH/share/wasi-sysroot"

# bindgen and rustc flags
export BINDGEN_EXTRA_CLANG_ARGS_WASM32_WASIP1="-isystem $WASI_SYSROOT/include"
export CARGO_TARGET_WASM32_WASIP1_LINKER="$WASI_SDK_PATH/bin/clang"

# relocation-model fully relocatable position independent code, machine instructions need to use relative addressing modes.
# Equivalent to the "uppercase" -fPIC or -fPIE options in other compilers, depending on the produced crate types.
# pass the sysroot down to the linker
#WASI_LINK_ARGS="-Clink-arg=-L$WASI_SYSROOT/lib/wasm32-wasip1 -Clink-arg=-lclang_rt.builtins-wasm32"
export CARGO_TARGET_WASM32_WASIP1_RUSTFLAGS="-Crelocation-model=pic --sysroot=$WASI_SYSROOT"

# opt out rust-lld ?? -Zlinker-features=-lld 

#export CC="$WASI_SDK_PATH/bin/clang"
#export CXX="$WASI_SDK_PATH/bin/clang++"
# export LIBCLANG_PATH=/path/to/custom/libclang

. $SDKROOT/wasm32-wasi-shell.sh
. $SDKROOT/${CONFIG:-config}


# set pg_config (wrapper) path
echo '/opt/python-wasm-sdk/wasisdk/bin/wasi-run /tmp/pglite/bin/pg_config.wasi "$@"' > /tmp/pglite/bin/pg_config
export PATH="/tmp/pglite/bin:$PATH"

# pgrx bindgen flags
export PGRX_PG_CONFIG_PATH=/tmp/pglite/bin/pg_config_wrapper
export PGRX_BINDGEN_NO_DETECT_INCLUDES=1

echo "building the extension pgrx-wasi/pgrx-examples/$1"
pushd pgrx-wasi/pgrx-examples/$1

cargo +nightly build -Z build-std=core,alloc --verbose --target wasm32-wasip1 --lib
popd