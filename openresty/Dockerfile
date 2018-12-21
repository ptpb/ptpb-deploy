FROM openresty/openresty:alpine-fat

RUN apk add --no-cache --virtual .build-deps openssl luarocks haveged

RUN luarocks install lua-resty-auto-ssl

RUN mkdir -p /etc/openresty/certs /etc/openresty/conf.d /etc/openresty/conf /etc/openresty/logs

RUN cp /usr/local/openresty/nginx/conf/mime.types /etc/openresty/conf

RUN haveged

RUN openssl req -x509 -nodes \
        -days 1000 \
        -newkey rsa:4096 \
        -keyout /etc/openresty/certs/fallback.key \
        -out /etc/openresty/certs/fallback.crt \
        -subj '/CN=fallback'

RUN openssl dhparam \
        -out /etc/openresty/certs/dhparam.pem \
        2048 2> /dev/null

ADD auto_ssl.conf ptpb.conf /etc/openresty/conf.d/

ADD openresty.conf /etc/openresty/conf/

CMD ["/usr/local/openresty/bin/openresty", "-g", "daemon off;", "-p", "/etc/openresty", "-c", "conf/openresty.conf"]
