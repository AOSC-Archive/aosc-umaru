source lib/kconfig_enum.sh

source ./.config

binutils_ver=$(kconfig_enum CONFIG_TOOLCHAIN_BINUTILS_VER_2_25_1 2.25.1)
