#!/bin/bash

usage() {
  echo -e "\nUsage: docker run --network=none lapwat/crypto-wallet-generator token... [--passphrase \"PASSPHRASE\"] \n" 1>&2
  exit 1
}

# check that an argument was given
if [[ $# -eq 0 ]]; then
  echo "You must specify at least one token."
  usage
fi

for TOKEN in "$@"
do
    TOKEN=${TOKEN^^}
    case $TOKEN in
        ETH)
            echo "----- Generating $TOKEN wallet"
            ./ether.sh
            echo "----- Done";;
        *) echo "$TOKEN not yet implemented. You can ask for its support by creating an issue at https://github.com/lapwat/crypto-wallet-generator/issues.";
    esac
done
