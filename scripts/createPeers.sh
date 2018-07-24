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
		# export i=$i
		echo 'server {
			listen 80;
			server_name peer'$i'.ezira.io;
			
			location /health {
					proxy_set_header x-real-IP             $remote_addr;
					proxy_set_header x-forwarded-for	$proxy_add_x_forwarded_for;
					# proxy_set_header Upgrade                 $http_upgrade;
					# proxy_set_header Connection              $connection_upgrade;
					proxy_set_header host               $host;
					proxy_http_version 1.1;
					proxy_pass http://'$subnet$i':8090;
			}
			location / {
					proxy_set_header x-real-IP             $remote_addr;
					proxy_set_header x-forwarded-for	$proxy_add_x_forwarded_for;
					# proxy_set_header Upgrade                 $http_upgrade;
					# proxy_set_header Connection              $connection_upgrade;
					proxy_set_header host               $host;
					proxy_http_version 1.1;
					proxy_pass http://'$subnet$i':2001;
			}
		}
		' > /etc/nginx/sites-enabled/peer$i
		# cp ./resources/peerX.txt ./db/peer$itemplate.txt
		# sed 's/$subnet/subnet/g;s/$i/i/g' ./db/peer$itemplate.txt > /etc/nginx/sites-enabled/peer$i

		# envsubst < ./db/peer$itemplate.txt > /etc/nginx/sites-enabled/peer$i
		echo catting
		cat /etc/nginx/site-enabled/peer$i
		sleep 1
done