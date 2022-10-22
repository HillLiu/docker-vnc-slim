FROM golang:1.14-buster AS easy-novnc-build
WORKDIR /src
RUN go mod init build && \
    go get github.com/geek1011/easy-novnc@v1.1.0 && \
    go build -o /bin/easy-novnc github.com/geek1011/easy-novnc

ARG VERSION=${VERSION:-[VERSION]}

FROM python:3.9-slim

ARG VERSION

COPY --from=easy-novnc-build /bin/easy-novnc /usr/local/bin/

# install 
COPY ./install-packages.sh /usr/local/bin/install-packages
RUN apt-get update \
  && INSTALL_VERSION=$VERSION install-packages \
  && rm /usr/local/bin/install-packages;
COPY ./docker/menu.xml /etc/xdg/openbox/
COPY ./docker/supervisord.conf /etc/
COPY ./docker/entrypoint.sh /usr/local/bin/

EXPOSE 8080
VOLUME /data
ENTRYPOINT ["entrypoint.sh"]
CMD ["server"]
