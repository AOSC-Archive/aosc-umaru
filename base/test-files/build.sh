source ./.config

[ "$CONFIG_BASE_TEST_FILES_QEMU_ARM_STATIC" ] && {
	echo "Copying QEMU files"
	mkdir -pv out/target/usr/bin
	cp /usr/bin/qemu-arm-static out/target/usr/bin/ || echo "Never mind."
	cp /usr/bin/qemu-static-arm out/target/usr/bin/ || echo "Never mind."
}

exit 0
