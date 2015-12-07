#! /bin/bash

source ./.config

for i in utils/build/proc/*.sh
do
	source $i
done
