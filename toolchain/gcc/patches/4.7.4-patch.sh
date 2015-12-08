patch -Np1 -i $PATCHES/gcc-4.7.3-musl-1.patch

case "$(gcc --version | cut -d " " -f 3 | sed -n '1p')" in
5.2*)
	patch -Np1 -i $PATCHES/gcc-4.7.4-build-on-gcc-5.2.patch ;;
esac
