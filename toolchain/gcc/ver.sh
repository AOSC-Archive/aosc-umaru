source lib/kconfig_enum.sh

source ./.config

gcc_ver=$(kconfig_enum CONFIG_TOOLCHAIN_GCC_VER_4_7_4 4.7.4)
