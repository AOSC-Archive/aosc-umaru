
rm -rf out/target
mkdir -p out/target

for i in base extra vendor vendor-pack
do
	[ ! -d $i ] && continue
	build_banner Building section $i
	utils/gen_sequence/main.sh $i
	for j in `cat out/build_sequence/$i`
	do
		sh $i/$j/build.sh
	done
done
