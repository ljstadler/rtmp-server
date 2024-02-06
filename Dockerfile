FROM alpine:latest

RUN apk add --no-cache build-base openssl-dev pcre-dev zlib-dev && \
    cd tmp && \
    wget -O nginx.tar.gz https://github.com/nginx/nginx/archive/refs/heads/master.tar.gz && \
    tar zxf nginx.tar.gz && \
    rm nginx.tar.gz && \
    wget -O nginx-rtmp-module.tar.gz https://github.com/arut/nginx-rtmp-module/archive/refs/heads/master.tar.gz && \
    tar zxf nginx-rtmp-module.tar.gz && \
    rm nginx-rtmp-module.tar.gz && \
    ls && \
    cd nginx-master && \
    ./auto/configure \
    --conf-path=/etc/nginx/nginx.conf \
    --http-log-path=/var/log/nginx/access.log \
    --error-log-path=/var/log/nginx/error.log \
    --with-threads \
    --with-http_ssl_module \
    --add-module=/tmp/nginx-rtmp-module-master --with-debug && \
    make && \
    make install && \
    rm -rf /tmp/* && \
    apk del build-base && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 1935

CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]