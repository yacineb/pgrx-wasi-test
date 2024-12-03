#!/bin/bash

echo "building the extension pgrx-wasi/pgrx-examples/$1"
pushd pgrx-wasi/pgrx-examples/$1

cargo +nightly build --lib --features pg16,pgrx/cshim --no-default-features

popd