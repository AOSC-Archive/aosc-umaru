source lib/kconfig_enum.sh

source ./.config

musl_ver=$(kconfig_enum CONFIG_TOOLCHAIN_LIBC_MUSL_VER_1_1_12 1.1.12)
