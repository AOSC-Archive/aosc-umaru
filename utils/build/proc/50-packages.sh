mkdir -p out/target

for i in base
do
	utils/gen_sequence/main.sh $i
	for j in `cat out/build_sequence/$i`
	do
		sh $i/$j/build.sh
	done
done
