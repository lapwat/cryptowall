#!/bin/sh
printf "Generating random key pair\n"
keys=$(openssl ecparam -name secp256k1 -genkey -noout | openssl ec -text -noout 2> /dev/null)

# extract private key in hex format, removing newlines, leading zeroes and semicolon
priv=$(printf "%s" "$keys" | grep priv -A 3 | tail -n +2 | tr -d '\n[:space:]:' | sed 's/^00//')

# make sure priv has correct length
if [ ${#priv} -ne 64 ]; then
  printf "Length error\n" 1>&2
  exit 1
fi

# extract public key in hex format, removing newlines, leading '04' and semicolon
pub=$(printf "%s" "$keys" | grep pub -A 5 | tail -n +2 | tr -d '\n[:space:]:' | sed 's/^04//')

# compute wallet address with keccak
addr=$(printf "%s" "$pub" | ./keccak-256sum -x -l | tr -d ' -' | tail -c 41)

printf "Private key: %s\n" "$priv"
printf "Public key:  04%s\n" "$pub"
printf "Address:     0x%s\n" "$addr"
