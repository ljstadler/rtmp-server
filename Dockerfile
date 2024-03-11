FROM alpine:latest

RUN apk add --no-cache build-base envsubst git openssl-dev pcre2-dev zlib-dev && \
    cd tmp && \
    git clone https://github.com/nginx/nginx && \
    git clone https://github.com/winshining/nginx-http-flv-module && \
    cd nginx && \
    ./auto/configure \
    --with-threads \
    --with-http_ssl_module \
    --with-http_auth_request_module \
    --conf-path=/etc/nginx/nginx.conf \
    --http-log-path=/var/log/nginx/access.log \
    --error-log-path=/var/log/nginx/error.log \
    --add-module=/tmp/nginx-http-flv-module && \
    make && \
    make install && \
    rm -rf /tmp/* && \
    apk del build-base git && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

COPY nginx.conf.template /etc/nginx/templates/nginx.conf.template

EXPOSE 1935

CMD ["sh", \
    "-c", \
    "envsubst '$AUTH' < /etc/nginx/templates/nginx.conf.template > /etc/nginx/nginx.conf && \
    /usr/local/nginx/sbin/nginx -g 'daemon off;'" \
]