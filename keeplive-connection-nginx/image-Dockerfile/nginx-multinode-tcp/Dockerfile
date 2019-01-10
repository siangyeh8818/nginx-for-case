FROM nginx

COPY nginx.conf /etc/nginx/nginx.conf
RUN apt-get -y update
RUN apt-get -y install procps
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
RUN chmod +x /etc/nginx/nginx.conf
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/bin/bash","-c","/docker-entrypoint.sh"]
