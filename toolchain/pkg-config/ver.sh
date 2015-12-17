source lib/kconfig_enum.sh

source ./.config

pkg_config_ver=$(kconfig_enum CONFIG_TOOLCHAIN_PKG_CONFIG_VER_0_29 0.29)
