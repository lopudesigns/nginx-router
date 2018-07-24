#!/bin/bash

chmod +x ./scripts/env.sh
./scripts/env.sh

mkdir -p ./sites-enabled/
mkdir -p ./db/

rm -f ./sites-enabled/peer*
rm -f ./db/peer* 

echo $peerCount

for (( i=0; i<=$peerCount; i++ ))
	do
		echo $i
		export i=$i
		cp ./resources/peerX.txt ./db/peer$itemplate.txt
		sed 's/$subnet/subnet/g;s/$i/i/g' ./db/peer$itemplate.txt > /etc/nginx/sites-enabled/peer$i

		# envsubst < ./db/peer$itemplate.txt > /etc/nginx/sites-enabled/peer$i
		echo catting
		cat /etc/nginx/site-enabled/peer$i
		sleep 1
done