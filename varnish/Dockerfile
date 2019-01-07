FROM alpine:3.8

RUN apk add --no-cache --virtual .runtime-deps varnish

ADD default.vcl /default.vcl

CMD ["varnishd", "-F", "-a", ":6081,HTTP", "-p", "http_gzip_support=off", "-f", "/default.vcl"]
