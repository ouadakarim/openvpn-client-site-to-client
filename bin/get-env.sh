#!/usr/bin/env bash

# --- Read environment variables from .env file ---
export $(egrep -v '^#' ./.env | xargs)

# --- Create a named for the named docker volume
export OVPN_DATA="ovpn-data-${OVPN_LABEL}"