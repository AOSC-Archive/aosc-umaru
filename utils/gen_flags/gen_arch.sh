AOSC_EC_ARCH=$(kconfig_enum CONFIG_ARCH_I386 i386 CONFIG_ARCH_ARM arm)

AOSC_EC_LIBC=$(kconfig_enum CONFIG_TOOLCHAIN_LIBC_MUSL musl)

source utils/gen_flags/gen_triplet.sh
