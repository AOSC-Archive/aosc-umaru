source ./.config
[ "$CONFIG_BASE_BUSYBOX" = "y" ] && sh base/utils/busybox/build.sh

mkdir -p out/target/bin

[ "$CONFIG_BASE_UTILS_SH_BUSYBOX" = "y" ] && ln -sfv busybox out/target/bin/sh

[ "$CONFIG_BASE_UTILS_CU_BUSYBOX" = "y" ] && {
	for i in chroot hostid nice who stty df basename cat chgrp chmod chown cp cut date dd dir dirname du echo env expand expr false fold groups head id link ln logname ls md5sum mkdir mkfifo mknod mktemp mv od pr printf pwd readlink realpath rm rmdir seq sha1sum sha256sum sha512sum shuf sleep sort stat sum sync tac tail tee test timeout touch tr true tty uname unexpand uniq unlink wc whoami yes "["
	do
		ln -sfv busybox "out/target/bin/$i"
	done
}
