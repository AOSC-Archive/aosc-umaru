triplet_machine_type=aoscec
triplet_os=linux

# TODO: ARM Support

if [ "$AOSC_EC_ARCH" = "i386" ]; then
	triplet_cpu=$(kconfig_enum ARCH_I386_MARCH_I486 i486 ARCH_I386_MARCH_PENTIUM i586)
	! [ "$triplet_cpu" ] && triplet_cpu=i686
	case $AOSC_EC_LIBC in
		musl) triplet_abi=musl ;;
		*) triplet_abi=unknown ;;
	esac
fi
	
AOSC_EC_TRIPLET=$triplet_cpu-$triplet_machine_type-$triplet_os-$triplet_abi
