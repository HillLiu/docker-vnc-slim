#!/bin/sh

###
# Environment ${INSTALL_VERSION} pass from Dockerfile
###

# INSTALL="pcmanfm vim fonts-arphic-ukai fonts-arphic-uming libfontconfig1 libfreetype6 xfonts-cyrillic xfonts-scalable"
PCMANFM="pcmanfm procps"
INSTALL="${PCMANFM} lxterminal vim fonts-arphic-ukai fonts-arphic-uming"

SYSTEM_DEPS="openbox tigervnc-standalone-server supervisor gosu"

echo "###"
echo "# Will install"
echo "###"
echo ""
echo $INSTALL
echo ""
echo "###"
echo "# Will install build tool"
echo "###"
echo ""
echo $SYSTEM_DEPS
echo ""

apt-get install -qq -y --no-install-recommends $SYSTEM_DEPS  || exit 1
apt-get install -qq -y --no-install-recommends $INSTALL || exit 2

#/* put your install code here */#
cp /etc/xdg/openbox/rc.xml.dpkg-new /etc/xdg/openbox/rc.xml
groupadd --gid 1000 app && \
    useradd --home-dir /data --shell /bin/bash --uid 1000 --gid 1000 app && \
    mkdir -p /data

exit 0
