source toolchain/gcc/ver.sh

fprint="$(mktemp)"

echo "$PWD"/out/tools $AOSC_EC_ARCH $AOSC_EC_LIBC $AOSC_EC_TRIPLET "$PWD"/out/sysroot > $fprint

if [ "$AOSC_EC_ARCH" = "arm" ]; then
	grep '^CONFIG_ARCH_ARM_FLOAT_ABI' ./.config >> $fprint
	grep '^CONFIG_ARCH_ARM_FPU' ./.config >> $fprint
fi

rm -rf $PWD/out/build/gcc-pass1
mkdir -p $PWD/out/build/gcc-pass1

utils/build_cache/cache_build gcc-pass1-$gcc_ver-$AOSC_EC_TRIPLET $fprint "$PWD"/out/build/gcc-pass1/destdir toolchain/gcc/pass1_build.sh

rm $fprint

cp -r "$PWD"/out/build/gcc-pass1/destdir/"$PWD"/out/* "$PWD"/out/
