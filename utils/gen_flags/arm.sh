arch_arm_march=$(kconfig_enum CONFIG_ARCH_ARM_MARCH_ARMV5TE -march=armv5te CONFIG_ARCH_ARM_MARCH_ARMV6 -march=armv6 CONFIG_ARCH_ARM_MARCH_ARMV7A -march=armv7a CONFIG_ARCH_ARM_MARCH_ARMV7VE -march=armv7ve)

arch_arm_mtune=$(kconfig_enum CONFIG_ARCH_ARM_MTUNE_ARM926EJS -mtune=arm926ej-s)

TARGET_CFLAGS_MACHINE+=" $arch_arm_march $arch_arm_mtune"
TARGET_CXXFLAGS_MACHINE+=" $arch_arm_march $arch_arm_mtune"

TARGET_CFLAGS+=" $arch_arm_march $arch_arm_mtune"
TARGET_CXXFLAGS+=" $arch_arm_march $arch_arm_mtune"

TARGET_MARCH=$arch_arm_march
