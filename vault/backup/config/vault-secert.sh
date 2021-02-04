#!/bin/bash

export VAULT_ADDR='http://127.0.0.1:8200'
export VAULT_API_ADDR='http://127.0.0.18200'
export VAULT_SKIP_VERIFY=true
export api_addr='http://127.0.0.1:8200'

echo $VAULT_ADDR
echo $KEY_1
vault -v

vault operator init >> /vault/config/key.log
KEY_1=$(cat /vault/config/keys.log | grep 'Unseal Key 1:' | awk '{print $4}')
KEY_2=$(cat /vault/config/keys.log | grep 'Unseal Key 2:' | awk '{print $4}')
KEY_3=$(cat /vault/config/keys.log | grep 'Unseal Key 3:' | awk '{print $4}')

vault operator unseal $KEY_1
vault operator unseal $KEY_2
vault operator unseal $KEY_3

tail -f /dev/null
