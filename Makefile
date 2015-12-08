build: .config
	utils/build/build.sh
.config:
	echo "Please configure first"
	make help
	exit 1
help:
	@echo "AOSC EC Makefile"
	@echo "make menuconfig for a configuration in a dialog-like interface"
menuconfig: utils/bin/mconf Bconfig
	utils/gen_bconfig/main.sh
	utils/bin/mconf Bconfig
oldconfig: utils/bin/conf Bconfig
	utils/gen_bconfig/main.sh
	utils/bin/conf --oldconfig Bconfig
utils/bin/mconf: utils/kconfig/mconf
	cp utils/kconfig/mconf utils/bin/mconf
utils/kconfig/mconf:
	make -C utils/kconfig mconf
utils/bin/conf: utils/kconfig/conf
	cp utils/kconfig/conf utils/bin/conf
utils/kconfig/conf:
	make -C utils/kconfig conf
.PHONY: help menuconfig build
