#!/bin/bash

usage() {
  echo -e "\nUsage: docker run --network=none lapwat/cryptowall token...\n" 1>&2
  exit 1
}

# check that an argument was given
if [[ $# -eq 0 ]]; then
  echo "You must specify at least one token."
  usage
fi

# loop over token list
echo "                               _                                _   _"
echo "                              | |                              | | | |"
echo "  ___   _ __   _   _   _ __   | |_    ___   __      __   __ _  | | | |"
echo " / __| | '__| | | | | | '_ \  | __|  / _ \  \ \ /\ / /  / _\` | | | | |"
echo "| (__  | |    | |_| | | |_) | | |_  | (_) |  \ V  V /  | (_| | | | | |"
echo " \___| |_|     \__, | | .__/   \__|  \___/    \_/\_/    \__,_| |_| |_|"
echo "                __/ | | |                                             "
echo "               |___/  |_|                                             "
echo "                                           KEEP'EM SAFE!"
for TOKEN in "$@"
do
    TOKEN=${TOKEN^^}
    echo "----- Generating $TOKEN wallet"
    case $TOKEN in
        BTC) ./BTC/BTC.sh;;
        ETH) ./ETH/ETH.sh;;
        XMR) ./XMR/XMR.py;;
        IOTA)./IOTA/IOTA.py;;
        *) echo "$TOKEN not yet implemented. You can ask for support of $TOKEN by opening an issue at https://github.com/lapwat/cryptowall/issues";
    esac
    echo "----- Done"
done
