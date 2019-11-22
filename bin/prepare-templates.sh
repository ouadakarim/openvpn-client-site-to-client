#!/usr/bin/env bash

source $(dirname $0)/get-env.sh

if [[ -z "${HOST}" ]];                        then echo "HOST is not set"; exit 1; fi
if [[ -z "${VPN_SUBNET}" ]];                  then echo "VPN_SUBNET is not set"; exit 1; fi
if [[ -z "${VPN_SUBNET_MASK}" ]];             then echo "VPN_SUBNET_MASK is not set"; exit 1; fi
if [[ -z "${EXPOSED_PRIVATE_SUBNET}" ]];      then echo "EXPOSED_PRIVATE_SUBNET is not set"; exit 1; fi
if [[ -z "${EXPOSED_PRIVATE_SUBNET_MASK}" ]]; then echo "EXPOSED_PRIVATE_SUBNET_MASK is not set"; exit 1; fi

echo "Copying templates to tmp directory ..."
mkdir -p tmp
cp -r templates/* tmp/

echo "Renaming templates in tmp directory ..."
mv tmp/openvpn.conf.template       tmp/openvpn.conf
mv tmp/gateway-client-ccd.template tmp/gateway-client-ccd
mv tmp/client.ovpn.template        tmp/client.ovpn
mv tmp/get-client.sh.template      tmp/get-client.sh

echo "Interpolating openvpn.conf ..."
sed -i "s/{{ HOST }}/${HOST}/g"                                               tmp/openvpn.conf
sed -i "s/{{ VPN_SUBNET }}/${VPN_SUBNET}/g"                                   tmp/openvpn.conf
sed -i "s/{{ VPN_SUBNET_MASK }}/${VPN_SUBNET_MASK}/g"                         tmp/openvpn.conf
sed -i "s/{{ EXPOSED_PRIVATE_SUBNET }}/${EXPOSED_PRIVATE_SUBNET}/g"           tmp/openvpn.conf
sed -i "s/{{ EXPOSED_PRIVATE_SUBNET_MASK }}/${EXPOSED_PRIVATE_SUBNET_MASK}/g" tmp/openvpn.conf


echo "Interpolating gateway_client_ccd ..."
sed -i "s/{{ EXPOSED_PRIVATE_SUBNET }}/${EXPOSED_PRIVATE_SUBNET}/g"           tmp/gateway-client-ccd
sed -i "s/{{ EXPOSED_PRIVATE_SUBNET_MASK }}/${EXPOSED_PRIVATE_SUBNET_MASK}/g" tmp/gateway-client-ccd

echo "Interpolating client.conf ..."
sed -i "s/{{ HOST }}/${HOST}/g"                                               tmp/client.ovpn

echo "Interpolating get-client.sh ..."
sed -i "s/{{ HOST }}/${HOST}/g"                                               tmp/get-client.sh

echo "All templates have been created ..."