source ./.config

[ "$CONFIG_BASE_DIRS_LINUX_VIRTFS" ] && {
	echo "Creating directories"
	mkdir -pv out/target/{proc,sys,dev}
}

exit 0
