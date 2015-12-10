source lib/kconfig_enum.sh

source ./.config

ncurses_ver=$(kconfig_enum CONFIG_EXTRA_NCURSES_VER_6_0 6.0)
