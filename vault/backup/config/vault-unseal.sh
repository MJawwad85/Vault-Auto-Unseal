#!/bin/bash

# Assumptions: vault is already initialized 

# Fetching first three keys to unseal the vault
KEY_1=$(cat /vault/config/keys.log | grep 'Unseal Key 1' | awk '{print $4}')
KEY_2=$(cat /vault/config/keys.log | grep 'Unseal Key 2' | awk '{print $4}')
KEY_3=$(cat /vault/config/keys.log | grep 'Unseal Key 3' | awk '{print $4}')

# Unseal using first key
curl --silent -X PUT \
  http://127.0.0.1:8200/v1/sys/unseal \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -d '{
  "key": "'$KEY_1'"
}'

# Unseal using second key
curl --silent -X PUT \
  http://127.0.0.1:8200/v1/sys/unseal \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -d '{
  "key": "'$KEY_2'"
}'

# Unseal using third key
curl --silent  -X PUT \
  http://127.0.0.1:8200/v1/sys/unseal \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -d '{
  "key": "'$KEY_3'"
}'

