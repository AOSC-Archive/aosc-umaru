arch_i386_march=$(kconfig_enum CONFIG_ARCH_I386_MARCH_I486 -march=i486 CONFIG_ARCH_I386_MARCH_PENTIUM -march=i586 CONFIG_ARCH_I386_MARCH_PPRO -march=i686 CONFIG_ARCH_I386_MARCH_SILVERMONT -march=silvermont)
arch_i386_mtune=$(kconfig_enum CONFIG_ARCH_I386_MTUNE_MARCH "$(echo $arch_i386_march | sed 's/^-march/-mtune/g')" CONFIG_ARCH_I386_MTUNE_GENERIC -mtune=generic CONFIG_ARCH_I386_MTUNE_SILVERMONT -mtune=silvermont)

TARGET_CFLAGS_MACHINE+=" $arch_i386_march $arch_i386_mtune"
TARGET_CXXFLAGS_MACHINE+=" $arch_i386_march $arch_i386_mtune"

TARGET_CFLAGS+=" $arch_i386_march $arch_i386_mtune"
TARGET_CXXFLAGS+=" $arch_i386_march $arch_i386_mtune"

TARGET_MARCH=$arch_i386_march
