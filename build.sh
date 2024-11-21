

export WASI_SDK_PATH=/opt/python-wasm-sdk/wasisdk/upstream

echo '/opt/python-wasm-sdk/wasisdk/bin/wasi-run /tmp/pglite/bin/pg_config "$@"' > /tmp/pglite/bin/pg_config

export PATH="/tmp/pglite/bin/:/opt/python-wasm-sdk/wasisdk/bin:$PATH"

export BINDGEN_EXTRA_CLANG_ARGS_wasm32_wasip1="-isystem /opt/python-wasm-sdk/wasisdk/upstream/share/wasi-sysroot/include"
# export RUSTFLAGS="--sysroot $WASI_SDK_PATH/share/wasi-sysroot"
export CC=$WASI_SDK_PATH/bin/clang 
export CXX=$WASI_SDK_PATH/bin/clang++
export CXXFLAGS="-fno-exceptions"
export PGRX_BINDGEN_NO_DETECT_INCLUDES=1

cargo build  --verbose --target wasm32-wasip1 --lib --features pg13 --no-default-features