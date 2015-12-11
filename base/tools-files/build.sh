source ./.config

[ "$CONFIG_BASE_TOOLS_FILES_MUSL_LIBC" ] && {
	echo "Copying shared libc from sysroot built by tools"
	mkdir -p out/target/{,usr/}lib/ out/target/bin
	cp -r out/sysroot/lib/ld-musl-*.so.1 out/target/lib/
	cp -r out/sysroot/usr/lib/libc.so out/target/usr/lib/
	ln -sfv /usr/lib/libc.so out/target/bin/ldd
	out/tools/bin/$AOSC_EC_TRIPLET-strip --strip-debug out/target/usr/lib/libc.so
}

exit 0
