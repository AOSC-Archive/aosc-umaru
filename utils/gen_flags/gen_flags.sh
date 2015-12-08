target_ooption=$(kconfig_enum CONFIG_OPTIMIZE_O0 -O0 CONFIG_OPTIMIZE_OS -Os CONFIG_OPTIMIZE_O1 -O1 CONFIG_OPTIMIZE_O2 -O2 CONFIG_OPTIMIZE_O3 -O3 CONFIG_OPTIMIZE_OFAST -Ofast CONFIG_OPTIMIZE_OG -Og)
target_ssp=$(kconfig_enum CONFIG_HARDENING_SSP_NONE -fno-stack-protector CONFIG_HARDENING_SSP_NORMAL -fstack-protector CONFIG_HARDENING_SSP_STRONG -fstack-protector-strong)
target_relro=$(kconfig_enum CONFIG_HARDENING_RELRO_PARTIAL -Wl,-z,relro CONFIG_HARDENING_RELRO_FULL -Wl,-z,relro,-z,now)
target_ftf=$(kconfig_enum CONFIG_HARDENING_FTF -D_FORTIFY_SOURCE=2)
target_pic=$(kconfig_enum CONFIG_HARDENING_PIC -fPIC)
target_pie=$(kconfig_enum CONFIG_HARDENING_PIE -fPIE)

TARGET_CFLAGS+=" $target_ooption $target_ssp $target_relro $target_pic $target_pie"
TARGET_CPPFLAGS+=" $target_ftf"
TARGET_CXXFLAGS+=" $target_ooption $target_ssp $target_relro $target_pic $target_pie"

par=$CONFiG_MAKE_JOBS

[[ $par == +([0-9]) ]] && PAR_MAKEFLAGS="-j$par"
