source lib/kconfig_enum.sh

source ./.config

linux_pc_ver=$(kconfig_enum CONFIG_AOSC_LINUX_PC_VER_4_3 4.3)
