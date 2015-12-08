target_ooption=$(kconfig_enum OPTIMIZE_O0 -O0 OPTIMIZE_OS -Os OPTIMIZE_O1 -O1 OPTIMIZE_O2 -O2 OPTIMIZE_O3 -O3 OPTIMIZE_OFAST -Ofast OPTIMIZE_OG -Og)
target_ssp=$(kconfig_enum HARDENING_SSP_NONE -fno-stack-protector HARDENING_SSP_NORMAL -fstack-protector HARDENING_SSP_STRONG -fstack-protector-strong)
target_relro=$(kconfig_enum HARDENING_RELRO_PARTIAL -Wl,-z,relro HARDENING_RELRO_FULL -Wl,-z,relro,-z,now)
target_ftf=$(kconfig_enum HARDENING_FTF -D_FORTIFY_SOURCE=2)
target_pic=$(kconfig_enum HARDENING_PIC -fPIC)
target_pie=$(kconfig_enum HARDENING_PIE -fPIE)

TARGET_CFLAGS+=" $target_ooption $target_ssp $target_relro $target_pic $target_pie"
TARGET_CPPFLAGS+=" $target_ftf"
TARGET_CXXFLAGS+=" $target_ooption $target_ssp $target_relro $target_pic $target_pie"
