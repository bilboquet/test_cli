#!/usr/bin/env bash

for f in helpers/*Caller.ts; do
    echo building $f
    ret=$(npx asc --noEmit -o $f.wasm $f 2>&1)

    # if $ret is not an empty string, exit with error
    if [ -z "$ret" ]; then
        echo "build ok"
    else
        echo "$ret"
        exit 1
    fi
done
