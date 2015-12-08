source ./.config

if [ "$CONFIG_TOOLCHAIN_LIBC_MUSL" = "y" ]; then
	source toolchain/libc/musl/build.sh
fi
