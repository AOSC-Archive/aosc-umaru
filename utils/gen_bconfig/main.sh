for i in base extra vendor vendor-pack
do
	utils/gen_bconfig/sub.sh $i
done
