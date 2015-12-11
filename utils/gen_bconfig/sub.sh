#! /bin/bash
rm -f $1/Bconfig

[ -e $1/sections/list ] && use_sec=1 || use_sec=0

cat $1/Bconfig.head > $1/Bconfig.tmp

((use_sec)) && for sec in $(cat $1/sections/list)
do
	echo >> $1/Bconfig.tmp
	echo "source \"$1/sections/${sec}.Bconfig\"" >> $1/Bconfig.tmp
	echo >> $1/Bconfig.tmp
	cat $1/sections/${sec}.Bconfig.head > $1/sections/${sec}.Bconfig.tmp
done

for i in $1/*/Bconfig
do
	sec=$(cat $(dirname $i)/section 2>/dev/null)
	[ "$sec" ] || sec=unspecified
	if ! (($use_sec)); then
		echo >> $1/Bconfig.tmp
		echo "source \"$i\"" >> $1/Bconfig.tmp
		echo >> $1/Bconfig.tmp
	else
		echo >> $1/sections/${sec}.Bconfig.tmp
		echo "source \"$i\"" >> $1/sections/${sec}.Bconfig.tmp
		echo >> $1/sections/${sec}.Bconfig.tmp
	fi
done

((use_sec)) && for sec in $(cat $1/sections/list)
do
	cat $1/sections/${sec}.Bconfig.tail >> $1/sections/${sec}.Bconfig.tmp
	mv $1/sections/${sec}.Bconfig.tmp $1/sections/${sec}.Bconfig
done

cat $1/Bconfig.tail >> $1/Bconfig.tmp
mv $1/Bconfig.tmp $1/Bconfig
