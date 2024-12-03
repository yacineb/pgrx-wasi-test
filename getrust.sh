#!/bin/sh

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > getrust
bash ./getrust -y -t wasm32-unknown-unknown --default-toolchain nightly

rustup target add wasm32-unknown-unknown
rustup target add wasm32-unknown-emscripten
rustup target add wasm32-wasip1

cargo install cargo-local-install --force