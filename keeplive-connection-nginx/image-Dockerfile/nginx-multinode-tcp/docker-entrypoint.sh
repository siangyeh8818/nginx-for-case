#!/bin/bash

#CONNECTION_LIMIT=65536
#KEEPLOVE_VALUE=1000
#NGINX_WORKER=2
#NGINXPORT=31122
#NGINXPORT2=31119
#NGINXPORT3=31121
#K8SWORKIP=10.22.14.11,10.22.15.11,10.22.14.12,10.22.15.12
STREAM_INFLUX=""
STREAM_PROMETHEUS_SYSTEM=""
STREAM_PROMETHEUS_OPENFAAS=""
STREAM_PROMETHEUS_MONITOR=""
STREAM_PROMETHEUS_CEPH=""

OIFS="$IFS"
IFS=','
read -a new_string <<< "${K8SWORKIP}"
IFS="$OIFS"
for i in "${new_string[@]}"
do     
   temp="server $i:$NGINXPORT weight=5 max_fails=1 fail_timeout=10s;\n" 
   STREAM_INFLUX="${STREAM_INFLUX}           ${temp}"
done
sleep 1s
OIFS="$IFS"
IFS=','
read -a new_string <<< "${K8SWORKIP}"
IFS="$OIFS"
for i in "${new_string[@]}"
do
   temp="server $i:$NGINXPORT2 weight=5 max_fails=1 fail_timeout=10s;\n"
   STREAM_PROMETHEUS_SYSTEM="${STREAM_PROMETHEUS_SYSTEM}           ${temp}"
done
sleep 1s
OIFS="$IFS"
IFS=','
read -a new_string <<< "${K8SWORKIP}"
IFS="$OIFS"
for i in "${new_string[@]}"
do
   temp="server $i:$NGINXPORT3 weight=5 max_fails=1 fail_timeout=10s;\n"
   STREAM_PROMETHEUS_OPENFAAS="${STREAM_PROMETHEUS_OPENFAAS}           ${temp}"
done
sleep 1s
OIFS="$IFS"
IFS=','
read -a new_string <<< "${K8SWORKIP}"
IFS="$OIFS"
for i in "${new_string[@]}"
do
   temp="server $i:$NGINXPORT4 weight=5 max_fails=1 fail_timeout=10s;\n"
   STREAM_PROMETHEUS_MONITOR="${STREAM_PROMETHEUS_MONITOR}           ${temp}"
done
sleep 1s
OIFS="$IFS"
IFS=','
read -a new_string <<< "${K8SWORKIP}"
IFS="$OIFS"
for i in "${new_string[@]}"
do
   temp="server $i:$NGINXPORT5 weight=5 max_fails=1 fail_timeout=10s;\n"
   STREAM_PROMETHEUS_CEPH="${STREAM_PROMETHEUS_CEPH}           ${temp}"
done
sleep 1s
sed -i s"/<UPSTREAM_CONTENT1>/$STREAM_INFLUX/g" /etc/nginx/nginx.conf
sed -i s"/<UPSTREAM_CONTENT2>/$STREAM_PROMETHEUS_SYSTEM/g" /etc/nginx/nginx.conf
sed -i s"/<UPSTREAM_CONTENT3>/$STREAM_PROMETHEUS_OPENFAAS/g" /etc/nginx/nginx.conf
sed -i s"/<UPSTREAM_CONTENT4>/$STREAM_PROMETHEUS_MONITOR/g" /etc/nginx/nginx.conf
sed -i s"/<UPSTREAM_CONTENT5>/$STREAM_PROMETHEUS_CEPH/g" /etc/nginx/nginx.conf
sed -i s"/<CONNECTION_LIMIT>/$CONNECTION_LIMIT/g" /etc/nginx/nginx.conf
sed -i s"/<DESTINATION_PORT>/$DESTINATION_PORT/g" /etc/nginx/nginx.conf
sed -i s"/<NGINXPORT1>/$NGINXPORT/g" /etc/nginx/nginx.conf
sed -i s"/<KEEPLOVE_VALUE>/$KEEPLOVE_VALUE/g" /etc/nginx/nginx.conf
sed -i s"/<NGINX_WORKER>/$NGINX_WORKER/g" /etc/nginx/nginx.conf
sed -i s"/<NGINXPORT2>/$NGINXPORT2/g" /etc/nginx/nginx.conf
sed -i s"/<NGINXPORT3>/$NGINXPORT3/g" /etc/nginx/nginx.conf
sed -i s"/<NGINXPORT4>/$NGINXPORT4/g" /etc/nginx/nginx.conf
sed -i s"/<NGINXPORT5>/$NGINXPORT5/g" /etc/nginx/nginx.conf
sed -i s"/<INTERNEL-NGINXPORT2>/$INTERNEL_NGINXPORT2/g" /etc/nginx/nginx.conf
sed -i s"/<INTERNEL-NGINXPORT3>/$INTERNEL_NGINXPORT3/g" /etc/nginx/nginx.conf
sed -i s"/<INTERNEL-NGINXPORT4>/$INTERNEL_NGINXPORT4/g" /etc/nginx/nginx.conf
sed -i s"/<INTERNEL-NGINXPORT5>/$INTERNEL_NGINXPORT5/g" /etc/nginx/nginx.conf

cat /etc/nginx/nginx.conf
nginx -t
nginx
sleep inf
