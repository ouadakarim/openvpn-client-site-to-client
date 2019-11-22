#!/usr/bin/env bash
set -e

# --- Read environment variables from .env file ---
source ./bin/get-env.sh

if [[ -z "${OVPN_DATA}" ]];         then echo "OVPN_DATA is not set"; exit 1; fi
if [[ -z "${HOST}" ]];              then echo "HOST is not set"; exit 1; fi
if [[ -z "${GATEWAY_CLIENT_CN}" ]]; then echo "GATEWAY_CLIENT_CN is not set"; exit 1; fi

# --- Prepare configuration files
./bin/prepare-templates.sh

# --- Initial Docker volume setup
docker volume create --name ${OVPN_DATA}

docker run -v ${OVPN_DATA}:/etc/openvpn --log-driver=none --rm kylemanna/openvpn ovpn_genconfig -u udp://${HOST}
docker run -v ${OVPN_DATA}:/etc/openvpn --log-driver=none --rm -it kylemanna/openvpn ovpn_initpki

./bin/cp-templates.sh

./bin/enable-service.sh

./bin/create-client.sh ${GATEWAY_CLIENT_CN}

./bin/cleanup.sh