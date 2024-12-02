#!/bin/sh
SDKROOT=/tmp/python-wasm-sdk

echo downloading wasm sdk

rm -rf $SDKROOT
mkdir -p $SDKROOT

DOWNLOAD_LINK=https://github.com/pygame-web/python-wasi-sdk/releases/download/24.0.4/python3.13-wasi-sdk-Ubuntu-22.04.tar.lz4
wget -qO- $DOWNLOAD_LINK | lz4 -d | tar -xf - -C $SDKROOT
mv $SDKROOT/opt/python-wasm-sdk/* $SDKROOT/

echo patch wasi sdk
cp -r ./sdk-fix/* $SDKROOT/wasisdk/upstream/
