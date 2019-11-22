#!/usr/bin/env bash

source $(dirname $0)/get-env.sh

if [[ -z "${OVPN_LABEL}" ]]; then echo "OVPN_LABEL is not set"; exit 1; fi

# --- Run OpenVPN as a Service on the host machine
curl -L https://raw.githubusercontent.com/kylemanna/docker-openvpn/master/init/docker-openvpn%40.service | sudo tee /etc/systemd/system/docker-openvpn@.service
systemctl enable --now docker-openvpn@${OVPN_LABEL}.service
