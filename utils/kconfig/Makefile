lxdialog := lxdialog/checklist.o lxdialog/util.o lxdialog/inputbox.o
lxdialog += lxdialog/textbox.o lxdialog/yesno.o lxdialog/menubox.o

conf-objs	:= conf.o  zconf.tab.o
mconf-objs     := mconf.o zconf.tab.o $(lxdialog)
nconf-objs     := nconf.o zconf.tab.o nconf.gui.o
kxgettext-objs	:= kxgettext.o zconf.tab.o
qconf-cxxobjs	:= qconf.o
qconf-objs	:= zconf.tab.o
gconf-objs	:= gconf.o zconf.tab.o

CFLAGS += -DCURSES_LOC="<ncurses.h>"

conf: $(conf-objs)
	gcc $(conf-objs) -o conf
mconf: $(mconf-objs)
	gcc $(mconf-objs) -lncursesw -o mconf

zconf.hash.c: zconf.hash.c_shipped
	cp zconf.hash.c_shipped zconf.hash.c
zconf.tab.c: zconf.tab.c_shipped zconf.hash.c
	cp zconf.tab.c_shipped zconf.tab.c
zconf.lex.c: zconf.lex.c_shipped
	cp zconf.lex.c_shipped zconf.lex.c

