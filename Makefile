build: .config
	echo "Not implemented yet"
.config:
	echo "Please configure first"
	make help
	exit 1
help:
	@echo "AOSC EC Makefile"
	@echo "make menuconfig for a configuration in a dialog-like interface"
menuconfig: utils/bin/mconf Bconfig
	utils/bin/mconf Bconfig
utils/bin/mconf: utils/kconfig/mconf
	cp utils/kconfig/mconf utils/bin/mconf
utils/kconfig/mconf:
	make -C utils/kconfig mconf
.PHONY: help menuconfig build
