#!/usr/bin/env bash

source $(dirname $0)/get-env.sh

CLIENT_CN=$1

if [[ -z "${CLIENT_CN}" ]]; then echo "Missing positional parameter CLIENT_CN"; exit 1; fi
if [[ -z "${OVPN_DATA}" ]]; then echo "OVPN_DATA is not set"; exit 1; fi

docker run -v ${OVPN_DATA}:/etc/openvpn --log-driver=none --rm -it kylemanna/openvpn easyrsa build-client-full ${CLIENT_CN} nopass
docker run -v ${OVPN_DATA}:/etc/openvpn --log-driver=none --rm kylemanna/openvpn /etc/openvpn/bin/get-client ${CLIENT_CN} > output/${CLIENT_CN}.ovpn

echo "Client config for ${CLIENT_CN} has been successfully created."