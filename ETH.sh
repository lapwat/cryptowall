#!/bin/sh

if [[ $# -eq 1 ]]; then
    echo "Using SHA256($1) as private key"
    priv=$(echo "$1" | sha256sum | tr -d ' ')

    # see https://stackoverflow.com/questions/48101258/how-to-convert-an-ecdsa-key-to-pem-format/49213805#49213805
    binary="302e0201010420${priv}a00706052b8104000a"
    keys==$(echo "$binary" | xxd -r -p | openssl ec -inform DER -text -noout)
else
    echo "Generating random key pair"
    keys=$(openssl ecparam -name secp256k1 -genkey -noout | openssl ec -text -noout 2> /dev/null)
fi

# extract private key in hex format, removing newlines, leading zeroes and semicolon
priv=$(printf "%s\n" $keys | grep priv -A 3 | tail -n +2 | tr -d '\n[:space:]:' | sed 's/^00//')

# make sure priv has correct length
if [ ${#priv} -ne 64 ]; then
    echo "length error"
    exit
fi

# extract public key in hex format, removing newlines, leading '04' and semicolon
pub=$(printf "%s\n" $keys | grep pub -A 5 | tail -n +2 | tr -d '\n[:space:]:' | sed 's/^04//')
addr=$(echo $pub | ./keccak-256sum -x -l | tr -d ' -' | tail -c 41)

echo "Private key: $priv"
echo "Public key:  04$pub"
echo "Address:     0x$addr"
