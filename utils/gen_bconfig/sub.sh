#! /bin/bash
rm -f $1/Bconfig
cat $1/Bconfig.head > $1/Bconfig.tmp
for i in `find $1 -name Bconfig`
do
	echo >> $1/Bconfig.tmp
	echo "source \"$i\"" >> $1/Bconfig.tmp
	echo >> $1/Bconfig.tmp
done
cat $1/Bconfig.tail >> $1/Bconfig.tmp
mv $1/Bconfig.tmp $1/Bconfig
