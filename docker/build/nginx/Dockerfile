FROM nginx:1.19-alpine

RUN apk add nginx-mod-http-headers-more
COPY ./docker/build/nginx/nginx.conf /etc/nginx/nginx.conf
RUN adduser -u 1000 -D -S -G www-data www-data
COPY ./docker/build/nginx/conf.d /etc/nginx/conf.d/
