source ./.config
[ "$CONFIG_BASE_BUSYBOX" = "y" ] && sh base/utils/busybox/build.sh

mkdir -p out/target/bin

[ "$CONFIG_BASE_UTILS_SH_BUSYBOX" = "y" ] && ln -sfv busybox out/target/bin/sh
