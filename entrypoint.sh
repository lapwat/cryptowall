#!/bin/bash

# check that an argument was given
if [[ $# -eq 0 ]]; then
  printf "You must specify at least one token.\nUsage: docker run --network=none lapwat/cryptowall token...\n" 1>&2
  exit 1
fi

printf "                               _                                _   _\n"
printf "                              | |                              | | | |\n"
printf "  ___   _ __   _   _   _ __   | |_    ___   __      __   __ _  | | | |\n"
printf " / __| | '__| | | | | | '_ \  | __|  / _ \  \ \ /\ / /  / _\` | | | | |\n"
printf "| (__  | |    | |_| | | |_) | | |_  | (_) |  \ V  V /  | (_| | | | | |\n"
printf " \___| |_|     \__, | | .__/   \__|  \___/    \_/\_/    \__,_| |_| |_|\n"
printf "                __/ | | |                                             \n"
printf "               |___/  |_|                                             \n"
printf "                                           KEEP'EM SAFE!              \n"

# loop over token list
for TOKEN in "$@"
do
    TOKEN=${TOKEN^^}
    printf "%s Generating %s wallet\n" "-----" "$TOKEN"
    case $TOKEN in
        BTC) ./BTC/BTC.sh;;
        ETH) ./ETH/ETH.sh;;
        XMR) ./XMR/XMR.py;;
        IOTA)./IOTA/IOTA.py;;
        *) printf "%s not yet implemented. You can ask for support of %s by opening an issue at https://github.com/lapwat/cryptowall/issues\n" $TOKEN $TOKEN;
    esac
    printf "%s Done\n" "-----"
done
