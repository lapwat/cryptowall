#!/bin/bash

usage() {
  echo -e "\nUsage: docker run --network=none lapwat/cryptowall [-p \"passphrase\"] token...\n" 1>&2
  exit 1
}

# check that an argument was given
if [[ $# -eq 0 ]]; then
  echo "You must specify at least one token."
  usage
fi

# retrieve passphrase if given
while getopts "p:" OPT
do
  case "$OPT" in
    p)
      PASSPHRASE=$OPTARG
      shift
      shift
      ;;
    \?)
      usage
      ;;
  esac
done

# loop over token
for TOKEN in "$@"
do
    TOKEN=${TOKEN^^}
    echo "----- Generating $TOKEN wallet"
    case $TOKEN in
        BTC) ./BTC.sh $PASSPHRASE;;
        ETH) ./ETH.sh $PASSPHRASE;;
        XMR) ./XMR.sh $PASSPHRASE;;
        IOTA) python ./IOTA.py $PASSPHRASE;;
        *) echo "$TOKEN not yet implemented. You can ask for support of $TOKEN by opening an issue at https://github.com/lapwat/cryptowall/issues.";
    esac
    echo "----- Done"
done
