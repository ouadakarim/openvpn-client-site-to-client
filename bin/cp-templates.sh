#!/usr/bin/env bash

source $(dirname $0)/get-env.sh

if [[ -z "${OVPN_LABEL}" ]];        then echo "OVPN_LABEL is not set"; exit 1; fi
if [[ -z "${OVPN_DATA}" ]];         then echo "OVPN_DATA is not set"; exit 1; fi
if [[ -z "${GATEWAY_CLIENT_CN}" ]]; then echo "GATEWAY_CLIENT_CN is not set"; exit 1; fi

HELPER_NAME="${OVPN_LABEL}-helper"

docker run -v ${OVPN_DATA}:/etc/openvpn --log-driver=none --rm -it kylemanna/openvpn mkdir -p /etc/openvpn/bin
docker run -v ${OVPN_DATA}:/etc/openvpn --name ${HELPER_NAME} --log-driver=none kylemanna/openvpn true
docker cp tmp/openvpn.conf ${HELPER_NAME}:/etc/openvpn/openvpn.conf
docker cp tmp/client.ovpn ${HELPER_NAME}:/etc/openvpn/client.ovpn
docker cp tmp/gateway-client-ccd ${HELPER_NAME}:/etc/openvpn/${GATEWAY_CLIENT_CN}
docker cp tmp/get-client.sh ${HELPER_NAME}:/etc/openvpn/bin/get-client
docker rm ${HELPER_NAME}