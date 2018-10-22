#!/bin/bash

sed -i s"/<CONNECTION_LIMIT>/$CONNECTION_LIMIT/g" /etc/nginx/nginx.conf
sed -i s"/<DESTINATION_IP>/$DESTINATION_IP/g" /etc/nginx/nginx.conf
sed -i s"/<DESTINATION_PORT>/$DESTINATION_PORT/g" /etc/nginx/nginx.conf
sed -i s"/<NGINXPORT>/$NGINXPORT/g" /etc/nginx/nginx.conf
sed -i s"/<KEEPLOVE_VALUE>/$KEEPLOVE_VALUE/g" /etc/nginx/nginx.conf
sed -i s"/<NGINX_WORKER>/$NGINX_WORKER/g" /etc/nginx/nginx.conf
cat /etc/nginx/nginx.conf
nginx -t
nginx 
sleep inf
