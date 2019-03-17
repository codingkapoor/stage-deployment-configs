#!/bin/bash

ip=$(ifconfig eth1 | grep 'inet addr' | awk '{ print substr($2,6) }')
echo "<h1>$ip $(hostname)</h1>" > /home/vagrant/ip.html

docker run -d \
           --name service-b \
           -p 8081:80 \
           --restart unless-stopped \
           -v /home/vagrant/ip.html:/usr/share/nginx/html/ip.html:ro \
           nginx
