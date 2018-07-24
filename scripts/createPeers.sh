chmod +x ./scripts/env.sh
./scripts/env.sh

mkdir -p ./sites-enabled/
mkdir -p ./db/

rm -f ./sites-enabled/peer*
rm -f ./db/peer* 

for (( i=0; i<$peerCount; i++ ))
	do
		echo $i
		export i=$i
		cp ./resources/peerX.txt ./db/peer$itemplate.txt
		envsubst < ./db/peer$itemplate.txt > /etc/nginx/sites-enabled/peer$i
		# echo catting
		# cat ./site-enabled/peer$i.txt
		sleep 1
done