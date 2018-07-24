docker run -d -p 80:80 -p 8080:8080 -p 443:443 \
	--name nginx-router \
	ld/nginx-router