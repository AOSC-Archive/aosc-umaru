source lib/kconfig_enum.sh

source ./.config

linux_headers_ver=$(kconfig_enum CONFIG_TOOLCHAIN_LINUX_HEADER_VER_4_3 4.3)
