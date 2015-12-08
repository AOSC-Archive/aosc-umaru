source ./.config
[ "$CONFIG_BASE_BUSYBOX" = "y" ] && sh base/utils/busybox/build.sh

mkdir -p out/target/bin

ln -sfv bin out/target/sbin

mkdir -p out/target/usr

ln -sfv ../bin out/target/usr/bin
ln -sfv ../bin out/target/usr/sbin

[ "$CONFIG_BASE_UTILS_SH_BUSYBOX" = "y" ] && ln -sfv busybox out/target/bin/sh

[ "$CONFIG_BASE_UTILS_CU_BUSYBOX" = "y" ] && {
	for i in chroot hostid nice who stty df basename cat chgrp chmod chown cp cut date dd dir dirname du echo env expand expr false fold groups head id link ln logname ls md5sum mkdir mkfifo mknod mktemp mv od pr printf pwd readlink realpath rm rmdir seq sha1sum sha256sum sha512sum shuf sleep sort stat sum sync tac tail tee test timeout touch tr true tty uname unexpand uniq unlink wc whoami yes "["
	do
		ln -sfv busybox "out/target/bin/$i"
	done
}

[ "$CONFIG_BASE_UTILS_INIT_BUSYBOX" = "y" ] && ln -sfv busybox out/target/bin/init

[ "$CONFIG_BASE_UTILS_INIT_SCRIPT" = "y" ] && install -m755 $CONFIG_BASE_UTILS_INIT_SCRIPT_PATH out/target/bin/init

[ "$CONFIG_BASE_UTILS_INIT_ROOT_SYMLINK" = "y" ] && ln -sfv bin/init out/target/init

