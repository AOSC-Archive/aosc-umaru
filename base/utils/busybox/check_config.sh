config=$1

shxt(){ printf '%s\n' "$1"; exit "${2:-1}"; }

source ./.config

grep '^CONFIG_STATIC=y' $config && static=y || static=n

if [ "$CONFIG_BASE_UTILS_BUSYBOX_CONFIG_SHARED" = "y" ]; then
	[ "$static" = "n" ] || shxt "You confingured a static busybox, but specified a shared one in main configuration."
else
	[ "$static" = "y" ] || shxt "You confingured a shared busybox, but specified a static one in main configuration."
fi

