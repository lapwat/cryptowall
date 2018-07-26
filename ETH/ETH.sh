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

# extract public key in hex format, removing newlines, leading '04' and semicolon
pub=$(printf "%s\n" $keys | grep pub -A 5 | tail -n +2 | tr -d '\n[:space:]:' | sed 's/^04//')

# compute wallet address with keccak
addr=$(echo $pub | ./keccak-256sum -x -l | tr -d ' -' | tail -c 41)

echo "Private key: $priv"
echo "Public key:  04$pub"
echo "Address:     0x$addr"
