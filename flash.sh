#!/usr/bin/env bash

set -e

rustup override set nightly

cargo build -Z build-std=core --target avr-atmega328p.json --release

pushd target/avr-atmega328p/release

avr-objcopy -O ihex blink.elf blink.hex
avrdude -pm328p -carduino -PCOM6 -D "-Uflash:w:blink.hex"
# Uncomment when running this from WSL2
# /mnt/c/Program\ Files\ \(x86\)/Arduino/hardware/tools/avr/bin/avrdude.exe -C "C:\Program Files (x86)\Arduino\hardware\tools\avr\etc\avrdude.conf" -pm328p -carduino -PCOM6 -D "-Uflash:w:blink.hex"

popd
