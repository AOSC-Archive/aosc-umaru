source lib/kconfig_enum.sh

source ./.config

bash_ver=$(kconfig_enum CONFIG_EXTRA_BASH_VER_4_3 4.3)
