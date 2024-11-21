WASI_SDK_PATH=/tmp/wasi-sdk
WASI_SDK_DOWNLOAD="https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-24/wasi-sdk-24.0-arm64-linux.tar.gz"
rm -rf $WASI_SDK_PATH && mkdir -p $WASI_SDK_PATH
wget -qO- $WASI_SDK_DOWNLOAD | tar -xzv -C $WASI_SDK_PATH