#!/bin/sh

# Sets up an OpenVPN container and generates configuration file ($VPN_LOGIN.openvpn)

# Should be command line parameters
# Listen port (8443 as an example)
PORT=8443
# Username
VPN_LOGIN="myuser"
# Listen domain
DOMAIN_NAME="mydomain.com"
# Listen protocol
PROTOCOL="tcp"

# Create everything in the current directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

mkdir $DIR/$PORT
mkdir $DIR/$PORT/data

cp $DIR/docker-compose.yml.sample $DIR/$PORT/docker-compose.yml
cd $DIR/$PORT

docker run -v $DIR/$PORT/data:/etc/openvpn --rm kylemanna/openvpn ovpn_genconfig -u $PROTOCOL://$DOMAIN_NAME:$PORT
docker run -v $DIR/$PORT/data:/etc/openvpn --rm -it kylemanna/openvpn ovpn_initpki

sed -i "s/#PORT#/$PORT/g" $DIR/$PORT/docker-compose.yml

docker-compose up -d

docker run -v $DIR/$PORT/data:/etc/openvpn --rm -it kylemanna/openvpn easyrsa build-client-full $VPN_LOGIN nopass
docker run -v $DIR/$PORT/data:/etc/openvpn --rm kylemanna/openvpn ovpn_getclient $VPN_LOGIN > $VPN_LOGIN.ovpn

