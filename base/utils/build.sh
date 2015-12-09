source ./.config
[ "$CONFIG_BASE_BUSYBOX" = "y" ] && sh base/utils/busybox/build.sh

mkdir -p out/target/bin

ln -sfv bin out/target/sbin

mkdir -p out/target/usr

ln -sfv ../bin out/target/usr/bin
ln -sfv ../bin out/target/usr/sbin

check_config_in_kconfig() {
	grep -q "^$1=y" $2
}

install_busybox_applet() {
	check_config_in_kconfig $1 $CONFIG_BASE_UTILS_BUSYBOX_CONFIG &&
	ln -sfv busybox "out/target/bin/$2"
}

[ "$CONFIG_BASE_UTILS_SH_BUSYBOX" = "y" ] && ln -sfv busybox out/target/bin/sh

[ "$CONFIG_BASE_UTILS_CU_BUSYBOX" = "y" ] && {
	install_busybox_applet CONFIG_CHROOT chroot
	install_busybox_applet CONFIG_HOSTID hostid
	install_busybox_applet CONFIG_WHO who
	install_busybox_applet CONFIG_STTY stty
	install_busybox_applet CONFIG_DF df
	install_busybox_applet CONFIG_BASENAME basename
	install_busybox_applet CONFIG_CAT cat
	install_busybox_applet CONFIG_CHGRP chgrp
	install_busybox_applet CONFIG_CHMOD chmod
	install_busybox_applet CONFIG_CHOWN chown
	install_busybox_applet CONFIG_CP cp
	install_busybox_applet CONFIG_CUT cut
	install_busybox_applet CONFIG_DATE date
	install_busybox_applet CONFIG_DD dd
	install_busybox_applet CONFIG_DIR dir
	install_busybox_applet CONFIG_DIRNAME dirname
	install_busybox_applet CONFIG_DU du
	install_busybox_applet CONFIG_ECHO echo
	install_busybox_applet CONFIG_ENV env
	install_busybox_applet CONFIG_EXPAND expand
	install_busybox_applet CONFIG_EXPR expr
	install_busybox_applet CONFIG_FALSE false
	install_busybox_applet CONFIG_FOLD fold
	install_busybox_applet CONFIG_GROUPS groups
	install_busybox_applet CONFIG_HEAD head
	install_busybox_applet CONFIG_ID id
	install_busybox_applet CONFIG_LN ln
	install_busybox_applet CONFIG_LOGNAME logname
	install_busybox_applet CONFIG_LS ls
	install_busybox_applet CONFIG_MD5SUM md5sum
	install_busybox_applet CONFIG_MKDIR mkdir
	install_busybox_applet CONFIG_MKFIFO mkfifo
	install_busybox_applet CONFIG_MKNOD mknod
	install_busybox_applet CONFIG_MKTEMP mktemp
	install_busybox_applet CONFIG_MV mv
	install_busybox_applet CONFIG_OD od
	install_busybox_applet CONFIG_PR pr
	install_busybox_applet CONFIG_PRINTF printf
	install_busybox_applet CONFIG_PWD pwd
	install_busybox_applet CONFIG_READLINK readlink
	install_busybox_applet CONFIG_REALPATH realpath
	install_busybox_applet CONFIG_RM rm
	install_busybox_applet CONFIG_RMDIR rmdir
	install_busybox_applet CONFIG_SEQ seq
	install_busybox_applet CONFIG_SHA1SUM sha1sum
	install_busybox_applet CONFIG_SHA256SUM sha256sum
	install_busybox_applet CONFIG_SHA512SUM sha512sum
	install_busybox_applet CONFIG_SHUF shuf
	install_busybox_applet CONFIG_SLEEP sleep
	install_busybox_applet CONFIG_SORT sort
	install_busybox_applet CONFIG_STAT stat
	install_busybox_applet CONFIG_SUM sum
	install_busybox_applet CONFIG_SYNC sync
	install_busybox_applet CONFIG_TAC tac
	install_busybox_applet CONFIG_TAIL tail
	install_busybox_applet CONFIG_TEE tee
	install_busybox_applet CONFIG_TEST test
	install_busybox_applet CONFIG_TIMEOUT timeout
	install_busybox_applet CONFIG_TOUCH touch
	install_busybox_applet CONFIG_TR tr
	install_busybox_applet CONFIG_TRUE true
	install_busybox_applet CONFIG_TTY tty
	install_busybox_applet CONFIG_UNAME uname
	install_busybox_applet CONFIG_UNEXPAND unexpand
	install_busybox_applet CONFIG_UNIQ uniq
	install_busybox_applet CONFIG_UNLINK unlink
	install_busybox_applet CONFIG_WC wc
	install_busybox_applet CONFIG_WHOAMI whoami
	install_busybox_applet CONFIG_YES yes
}

[ "$CONFIG_BASE_UTILS_INIT_BUSYBOX" = "y" ] && ln -sfv busybox out/target/bin/init

[ "$CONFIG_BASE_UTILS_INIT_SCRIPT" = "y" ] && install -m755 $CONFIG_BASE_UTILS_INIT_SCRIPT_PATH out/target/bin/init

[ "$CONFIG_BASE_UTILS_INIT_ROOT_SYMLINK" = "y" ] && ln -sfv bin/init out/target/init

