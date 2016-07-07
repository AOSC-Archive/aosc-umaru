patch -Np1 -i $PATCHES/gcc-5.2.0-musl.patch

case "$(gcc --version | cut -d " " -f 3 | sed -n '1p')" in
6.0*|6.1*)
	patch -Np1 -i $PATCHES/gcc-4.7.4-build-on-gcc-5.2.patch ;; # seems to be also working in this situation
esac

