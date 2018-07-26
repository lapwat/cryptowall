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

# extract public key in hex format, removing newlines and semicolon
pub=$(printf "%s" "$keys" | grep pub -A 5 | tail -n +2 | tr -d '\n[:space:]:')

# compute wif
extended="80$priv"
wif=$(printf "%s" "$extended" | xxd -r -p | base58 -c)

# compute address
hash160=$(printf "%s" "$pub"| xxd -r -p | openssl dgst -sha256 -binary | openssl rmd160 | cut -d" " -f2)
extended="00$hash160"
address=$(printf "%s" "$extended" | xxd -r -p | base58 -c)

printf "Private key    : %s\n" "$priv"
printf "Public key     : %s\n" "$pub"
printf "WIF            : %s\n" "$wif"
printf "Address        : %s\n" "$address"
