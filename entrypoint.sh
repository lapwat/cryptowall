#!/bin/bash

usage() {
  echo -e "\nUsage: docker run --network=none lapwat/crypto-wallet-generator token...\n" 1>&2
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
    echo "----- Generating $TOKEN wallet"
    case $TOKEN in
        ETH) ./eth/main.sh;;
        IOTA) python ./iota/main.py;;
        *) echo "$TOKEN not yet implemented. You can ask for support of $TOKEN by opening an issue at https://github.com/lapwat/cryptowall/issues.";
    esac
    echo "----- Done"
done
