source lib/kconfig_enum.sh

source ./.config

readline_ver=$(kconfig_enum CONFIG_EXTRA_READLINE_VER_6_3 6.3)
