source ./.config

[ "$CONFIG_BASE_TOOLS_FILES_MUSL_LIBC" ] && {
	echo "Copying shared libc from sysroot built by tools"
	mkdir -p out/target/{,usr/}lib/ out/target/bin
	cp -r out/sysroot/lib/ld-musl-*.so.1 out/target/lib/
	cp -r out/sysroot/usr/lib/libc.so out/target/usr/lib/
	ln -sfv /usr/lib/libc.so out/target/bin/ldd
	out/tools/bin/$AOSC_EC_TRIPLET-strip --strip-debug out/target/usr/lib/libc.so
}

[ "$CONFIG_BASE_TOOLS_FILES_LIBGCC_S" ] && {
	echo "Copying shared libgcc_s from sysroot built by tools"
	mkdir -p out/target/lib/
	cp out/tools/$AOSC_EC_TRIPLET/lib/libgcc_s.so.1 out/target/lib/
	ln -sfv /lib/libgcc_s.so.1 out/target/usr/lib/libgcc_s.so
	out/tools/bin/$AOSC_EC_TRIPLET-strip --strip-debug out/target/lib/libgcc_s.so.1
}

exit 0
