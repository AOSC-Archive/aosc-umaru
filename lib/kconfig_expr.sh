source lib/kconfig_enum.sh

kconfig_expr() {
	case $2 in
		with)
			val=$(kconfig_enum "$1" with)
			[ "$val" ] || val=without
			echo $val
			;;
		enable)
			val=$(kconfig_enum "$1" enable)
			[ "$val" ] || val=disable
			echo $val
			;;
		*)
			echo $2
			;;
	esac
}
