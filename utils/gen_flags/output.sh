OUTPUT_FILE=out/flags.sh

rm -f $OUTPUT_FILE

out() {
	while [ "$1" ]; do
		if [ "x$(eval echo \$$1)" != "x" ]; then
			echo "$1=\"$(eval echo \$$1)\"" >> $OUTPUT_FILE
		fi
		shift
	done
}

out AOSC_EC_ARCH
out TARGET_CFLAGS TARGET_CXXFLAGS
