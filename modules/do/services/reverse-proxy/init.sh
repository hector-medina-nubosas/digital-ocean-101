#!/bin/bash
apt update -y 
apt install docker.io -y 
mkdir -p /srv/nginx/conf.d
touch /srv/nginx/conf.d/default.conf 
cat > /srv/nginx/conf.d/default.conf  << EOF
server {
    listen 80;

    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
    }

    location /apache/ {
        rewrite  ^${server_pattern}/(.*)  /$1 break;
        proxy_pass http://${server_ip};
    }
} 
EOF
docker run -d -p 80:80 -v /srv/nginx/conf.d:/etc/nginx/conf.d nginx