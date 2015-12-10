arch_arm_march=$(kconfig_enum CONFIG_ARCH_ARM_MARCH_ARMV5TE -march=armv5te CONFIG_ARCH_ARM_MARCH_ARMV6 -march=armv6 CONFIG_ARCH_ARM_MARCH_ARMV7A -march=armv7-a CONFIG_ARCH_ARM_MARCH_ARMV7VE -march=armv7ve)

arch_arm_mtune=$(kconfig_enum CONFIG_ARCH_ARM_MTUNE_ARM926EJS -mtune=arm926ej-s)

arch_arm_float_abi=$(kconfig_enum CONFIG_ARCH_ARM_FLOAT_ABI_SOFT -mfloat-abi=soft CONFIG_ARCH_ARM_FLOAT_ABI_SOFTFP -mfloat-abi=softfp CONFIG_ARCH_ARM_FLOAT_ABI_HARD -mfloat-abi=hard)
arch_arm_fpu=$(kconfig_enum CONFIG_ARCH_ARM_FPU_VFPV2 -mfpu=vfp CONFIG_ARCH_ARM_FPU_VFPV3_D16 -mfpu=vfpv3-d16 CONFIG_ARCH_ARM_FPU_VFPV4 -mfpu=vfpv4 CONFIG_ARCH_ARM_FPU_NEON -mfpu=neon)

TARGET_CFLAGS_MACHINE+=" $arch_arm_march $arch_arm_mtune $arch_arm_float_abi $arch_arm_fpu"
TARGET_CXXFLAGS_MACHINE+=" $arch_arm_march $arch_arm_mtune $arch_arm_float_abi $arch_arm_fpu"

TARGET_CFLAGS+=" $arch_arm_march $arch_arm_mtune $arch_arm_float_abi $arch_arm_fpu"
TARGET_CXXFLAGS+=" $arch_arm_march $arch_arm_mtune $arch_arm_float_abi $arch_arm_fpu"

TARGET_MARCH=$arch_arm_march

AOSC_EC_ARM_FLOAT_ABI=$(echo $arch_arm_float_abi | cut -d = -f 2)
AOSC_EC_ARM_FPU=$(echo $arch_arm_fpu | cut -d = -f 2)
