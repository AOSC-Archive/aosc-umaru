#! /bin/bash

echo =====================================================================
echo Build started at `date`
echo =====================================================================

source ./.config

for i in utils/build/proc/*.sh
do
	source $i
done
