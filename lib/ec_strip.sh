ec_strip() {
	local res
	while [ "$1" ]; do
		shift
		[ ! -e "$1" ] && continue
		res="$(LC_ALL=C file "$1")"
		if echo $res | grep -q "ELF ..-bit ... shared object"; then
			chmod 755 "$1"
			out/tools/bin/$AOSC_EC_TRIPLET-strip --strip-unneeded "$1"
		elif echo $res | grep -q "ELF ..-bit ... executable"; then
			chmod 755 "$1"
			out/tools/bin/$AOSC_EC_TRIPLET-strip "$1"
		fi
	done
}
