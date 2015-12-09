#! /bin/bash

[ "$1" ] || exit 1

mkdir -p out/build_sequence

rm -f out/build_sequence/$1

source ./.config

group=$1

mkdir -p out/build_sequence/$(dirname group)

try_add() {
	name=$1
	grep -q '^'"$name"'$' out/build_sequence/$group 2>/dev/null && continue
	before=""
	kconfig=""
	[ -e $i/order ] && source $i/order
	[ "$kconfig" ] && [ "$(eval echo \$$kconfig)" != "y" ] && return 0
	[ "$before" ] && for i in $before
	do
		try_add $before
	done
	echo $1 >> out/build_sequence/$group
}

for i in $1/*
do
	[ ! -d $i ] && continue
	( [ ! -e $i/build.sh ] || [ ! -e $i/Bconfig ] ) && continue
	try_add $(basename $i)
done

exit 0
