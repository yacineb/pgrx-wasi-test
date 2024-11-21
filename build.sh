

export WASI_SDK_PATH=/opt/python-wasm-sdk/wasisdk/upstream

echo '/opt/python-wasm-sdk/wasisdk/bin/wasi-run /tmp/pglite/bin/pg_config "$@"' > /tmp/pglite/bin/pg_config

export PATH="/tmp/pglite/bin/:/opt/python-wasm-sdk/wasisdk/bin:$PATH"

export BINDGEN_EXTRA_CLANG_ARGS_wasm32_wasip1="-isystem /opt/python-wasm-sdk/wasisdk/upstream/share/wasi-sysroot/include"
# export RUSTFLAGS="--sysroot $WASI_SDK_PATH/share/wasi-sysroot"
# export CC=$WASI_SDK_PATH/bin/clang 
# export CXX=$WASI_SDK_PATH/bin/clang++
# export CXXFLAGS="-fno-exceptions"
# export PGRX_BINDGEN_NO_DETECT_INCLUDES=1

. /opt/python-wasm-sdk/wasm32-wasi-shell.sh

# install rust sdk
/opt/python-wasm-sdk/lang/rustsdk.sh
cargo +nightly build  --target wasm32-wasip2 --lib --features pg16,pgrx/cshim --no-default-features