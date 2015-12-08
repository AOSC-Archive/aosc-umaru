source ./.config

[ "$CONFIG_BASE_TOOLS_FILES_MUSL_LIBC" ] && {
	echo "Copying shared libc from sysroot built by tools"
	mkdir -p out/target/{,usr/}lib/
	cp -r out/sysroot/lib/ld-musl-*.so.1 out/target/lib/
	cp -r out/sysroot/usr/lib/libc.so out/target/usr/lib/
}

exit 0
