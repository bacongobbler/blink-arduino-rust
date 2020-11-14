#!/usr/bin/env bash

set -e

if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    echo "usage: $0 <path-to-binary.elf>" >&2
    exit 1
fi

if [ "$#" -lt 1 ]; then
    echo "$0: Expecting a .elf file" >&2
    exit 1
fi

cargo build --release

pushd target/avr-atmega328p/release

avr-objcopy -O ihex rust-arduino-blink.elf rust-arduino-blink.hex
avrdude -pm328p -carduino -PCOM6 -D "-Uflash:w:rust-arduino-blink.hex"

popd
