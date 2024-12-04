#!/bin/bash

pushd pgrx-wasi

echo install pgrx locally and symlink
cargo local-install

# add cargo-pgrx to PATH
export PATH="$(pwd)/bin:$PATH"

popd


echo "init development env once"
cargo pgrx init