source ./.config

if [ "$CONFIG_PACK_AOSC_INITRAMFS" = "y" ]; then
	cpio_path=$(readlink -m $CONFIG_PACK_AOSC_INITRAMFS_PATH)
	echo "Packing cpio archive: $cpio_path"
	(cd out/target; find . -print0 | sort -z | cpio --null -H newc -R 0:0 -o --quiet > $cpio_path)
fi
