#!/bin/bash

pushd pgrx-wasi

echo install pgrx locally and symlink
cargo local-install

popd

export PATH="$(pwd)/pgrx-wasi/bin:$PATH"

echo "init development env once"
cargo pgrx init