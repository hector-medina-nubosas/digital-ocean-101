#!/bin/bash
apt update -y 
apt install docker.io -y 
echo "Hello world from apache!" > /srv/index.html
docker run -d -p 80:80 -v /srv/index.html:/var/www/html/index.html php:5.6.40-apache