#!/bin/sh

if [[ $# -eq 1 ]]; then
    echo "Using SHA256($1) as private key"
    priv=$(echo "$1" | sha256sum | cut -d' ' -f1)

    # see https://stackoverflow.com/questions/48101258/how-to-convert-an-ecdsa-key-to-pem-format/49213805#49213805
    binary="302e0201010420${priv}a00706052b8104000a"
    keys=$(printf "$binary" | xxd -r -p | openssl ec -inform DER -text -noout 2> /dev/null)
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

# extract public key in hex format, removing newlines and semicolon
pub=$(printf "%s\n" $keys | grep pub -A 5 | tail -n +2 | tr -d '\n[:space:]:')
extended="80$priv"
wif=$(echo "$extended" | xxd -r -p | base58 -c)

hash160=$(echo -n $pub | xxd -r -p | openssl dgst -sha256 -binary | openssl rmd160 | cut -d" " -f2)
extended="00$hash160"
address=$(echo "$extended" | xxd -r -p | base58 -c)

echo "Private key    : $priv"
echo "Public key     : $pub"
echo "WIF            : $wif"
echo "Address        : $address"
