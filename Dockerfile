FROM alpine:latest

RUN apk --update add --no-cache build-base openssl-dev pcre-dev zlib-dev

WORKDIR /tmp

RUN wget https://nginx.org/download/nginx-1.24.0.tar.gz && \
    tar zxf nginx-1.24.0.tar.gz && \
    rm nginx-1.24.0.tar.gz && \
    wget https://github.com/arut/nginx-rtmp-module/archive/v1.2.2.tar.gz && \
    tar zxf v1.2.2.tar.gz && \
    rm v1.2.2.tar.gz

WORKDIR /tmp/nginx-1.24.0

RUN ./configure \
    --conf-path=/etc/nginx/nginx.conf \
    --http-log-path=/var/log/nginx/access.log \
    --error-log-path=/var/log/nginx/error.log \
    --with-threads \
    --with-http_ssl_module \
    --add-module=/tmp/nginx-rtmp-module-1.2.2 --with-debug && \
    make && \
    make install && \
    rm -rf /tmp/* && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

ENV PATH "${PATH}:/usr/local/nginx/sbin"

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 1935

CMD ["nginx", "-g", "daemon off;"]