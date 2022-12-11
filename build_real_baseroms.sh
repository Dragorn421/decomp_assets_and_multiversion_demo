#!/bin/bash
set -e

rm -rf baseroms
mkdir -p baseroms

make -C real_baserom clean
make -C real_baserom VERSION=0 baserom.bin
cp real_baserom/baserom.bin baseroms/baserom_v0.bin

make -C real_baserom clean
make -C real_baserom VERSION=1 baserom.bin
cp real_baserom/baserom.bin baseroms/baserom_v1.bin
