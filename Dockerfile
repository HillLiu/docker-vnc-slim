FROM --platform=linux/amd64 golang:1.14-buster AS easy-novnc-build
RUN mkdir -p /src && \
    cd /src && \
    go mod init build && \
    go get github.com/geek1011/easy-novnc@v1.1.0 && \
    go build -o /bin/easy-novnc github.com/geek1011/easy-novnc

ARG VERSION=${VERSION:-[VERSION]}

FROM --platform=linux/amd64 ubuntu:18.04

ARG VERSION

COPY --from=easy-novnc-build /bin/easy-novnc /usr/local/bin/

# install 
COPY ./install-packages.sh /usr/local/bin/install-packages
RUN apt-get update \
  && INSTALL_VERSION=$VERSION install-packages \
  && rm /usr/local/bin/install-packages;
COPY ./docker/menu.xml \
  ./docker/rc.xml \
  /etc/xdg/openbox/
COPY ./docker/supervisord.conf /etc/
COPY ./docker/entrypoint.sh /

EXPOSE 8080
VOLUME /app
ENTRYPOINT ["/entrypoint.sh"]
CMD ["server"]
