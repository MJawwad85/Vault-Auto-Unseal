#!/usr/bin/env bash
# Start vault
vault server -config /vault/config/vault.hcl

# Export values
export VAULT_SKIP_VERIFY=true
export VAULT_ADDR=http://127.0.0.1:8200
export VAULT_API_ADDR=http://127.0.0.18200
export api_addr=http://127.0.0.1:8200

vault operator init

# Parse unsealed keys
mapfile -t keyArray lt; lt;( grep "Unseal Key " lt; generated_keys.txt  | cut -c15- )

vault operator unseal ${keyArray[0]}
vault operator unseal ${keyArray[1]}
vault operator unseal ${keyArray[2]}

# Get root token
mapfile -t rootToken &lt; &lt;(grep "Initial Root Token: " &lt; generated_keys.txt  | cut -c21- )
echo ${rootToken[0]} &gt; root_token.txt

export VAULT_TOKEN=${rootToken[0]}

# Enable kv
vault secrets enable -version=1 kv

# Enable userpass and add default user
vault auth enable userpass
vault policy write spring-policy spring-policy.hcl
vault write auth/userpass/users/admin password=${SECRET_PASS} policies=spring-policy

# Add test value to my-secret
vault kv put kv/my-secret my-value=s3cr3t
