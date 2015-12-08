source lib/kconfig_enum.sh

source ./.config

busybox_ver=$(kconfig_enum CONFIG_BASE_UTILS_BUSYBOX_VER_1_24_1 1.24.1)
