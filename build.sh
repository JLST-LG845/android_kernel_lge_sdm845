#!/bin/sh
export PATH="/home/juleast/clang-proton/bin:/home/juleast/clang-proton/aarch64-linux-gnu/bin:${PATH}"
export ARCH=arm64

rm -rf ./out
mkdir -p out

echo "Select the device:"
echo "1. judyln"
echo "2. judypn"
echo "3. judyp"
read -p "Choose your device (1-3): " device_choice
case "${device_choice}" in
  1)
    device="judyln"
    ;;
  2)
    device="judypn"
    ;;
  3)
    device="judyp"
    ;;
  *)
    echo "Invalid choice!"
    echo "Exiting..."
    exit 1
    ;;
esac

make O=out lineageos_${device}_defconfig
make -j$(nproc --all) O=out \
                      ARCH=arm64 \
                      CC=clang \
                      CLANG_TRIPLE=aarch64-linux-gnu- \
                      CROSS_COMPILE=aarch64-linux-gnu- \
                      CROSS_COMPILE_ARM32=arm-linux-gnueabi-

