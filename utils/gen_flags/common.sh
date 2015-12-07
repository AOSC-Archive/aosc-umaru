kconfig_enum() {
	while [ "$1" ]; do
		if [ "$(eval echo \$$1)" = "y" ]; then
			echo $2
			return 0
		fi
		shift 2
	done
	return 1
}
