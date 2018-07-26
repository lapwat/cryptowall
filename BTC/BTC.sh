#!/bin/sh
echo "Generating random key pair"
keys=$(openssl ecparam -name secp256k1 -genkey -noout | openssl ec -text -noout 2> /dev/null)

# extract private key in hex format, removing newlines, leading zeroes and semicolon
priv=$(printf "%s\n" $keys | grep priv -A 3 | tail -n +2 | tr -d '\n[:space:]:' | sed 's/^00//')

# make sure priv has correct length
if [ ${#priv} -ne 64 ]; then
    echo "length error"
    exit
fi

# extract public key in hex format, removing newlines and semicolon
pub=$(printf "%s\n" $keys | grep pub -A 5 | tail -n +2 | tr -d '\n[:space:]:')

# compute wif
extended="80$priv"
wif=$(echo "$extended" | xxd -r -p | base58 -c)

# compute address
hash160=$(echo -n $pub | xxd -r -p | openssl dgst -sha256 -binary | openssl rmd160 | cut -d" " -f2)
extended="00$hash160"
address=$(echo "$extended" | xxd -r -p | base58 -c)

echo "Private key    : $priv"
echo "Public key     : $pub"
echo "WIF            : $wif"
echo "Address        : $address"
