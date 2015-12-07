#! /bin/bash

mkdir -p out

build_banner() {
	echo =====================================================================
	echo "$@"
	echo =====================================================================
}

build_fail() {
	build_banner Build failed. Reason: "$@"
	exit 1
}

build_banner Build started at `date`

source ./.config

for i in utils/build/proc/*.sh
do
	source $i
done
