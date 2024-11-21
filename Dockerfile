FROM alpine:latest

RUN apk add --no-cache build-base envsubst git openssl-dev pcre2-dev zlib-dev && \
    cd tmp && \
    git clone https://github.com/nginx/nginx && \
    git clone https://github.com/winshining/nginx-http-flv-module && \
    cd nginx && \
    ./auto/configure \
    --add-module=/tmp/nginx-http-flv-module && \
    make && \
    make install && \
    rm -rf /tmp/* && \
    apk del build-base git && \
    ln -sf /dev/stdout /usr/local/nginx/logs/access.log && \
    ln -sf /dev/stderr /usr/local/nginx/logs/error.log

COPY nginx.conf.template /usr/local/nginx/templates/nginx.conf.template

EXPOSE 1935

CMD ["sh", \
    "-c", \
    "envsubst '$AUTH' < /usr/local/nginx/templates/nginx.conf.template > /usr/local/nginx/conf/nginx.conf && \
    /usr/local/nginx/sbin/nginx -g 'daemon off;'" \
    ]