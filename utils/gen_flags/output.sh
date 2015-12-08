OUTPUT_FILE=out/flags.sh

rm -f $OUTPUT_FILE

out() {
	while [ "$1" ]; do
		if [ "x$(eval echo \$$1)" != "x" ]; then
			echo "export $1=\"$(eval echo \$$1)\"" >> $OUTPUT_FILE
		fi
		shift
	done
}

out AOSC_EC_ARCH AOSC_EC_LIBC AOSC_EC_TRIPLET
out TARGET_CFLAGS TARGET_CXXFLAGS TARGET_CFLAGS_MACHINE TARGET_CXXFLAGS_MACHINE TARGET_MARCH
out PAR_MAKEFLAGS
