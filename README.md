Cryptowall is an **offline** Docker container which generates random crypto wallets. It prints out the private key, public key, seed or any other usefull info to recover your wallet. It also gives the corresponding address to share in order to receive funds.

Commented scripts can be found in the folder named after the token. Methods used are described below & sources are given.

## Motivation

I wanted a tool to easily generate random wallets on the fly for various cryptocurrency. My scripts needed to be easily understood the transparent, that is why I shared the sources and used bash + OpenSSL where possible. For those who want to use my tool, the scripts needed to be computed offline to prevent any leak.

## Usage

Cryptowall currently supports Bitcoin, Ethereum and Iota tokens. Create an issue if you want a specific token to be implemented.

```sh
$ docker run --network=none lapwat/cryptowall btc eth iota
----- Generating BTC wallet                               
Generating random key pair
Private key    : dcd595b48df898a488aacf342c2c3e22ab0b61018a6753f84f607b161a192e52
Public key     : 04c77e8f4396f1798fb5e6ddccc205d1ea03eadb89f126682b97fb2f2dee9ef40921bdf8746b897092d53b810eec3aafdbed51552bed2a870d094013b6805fee6c
WIF            : 5KVYVpYkp6gc54gDYLVNAUBNFAjaFoRiRPVkeHGW6TkPf8z5Tkc
Address        : 1DiRb8N2Tee4A5cfvPyf4m5qoeQoCCaMzo
----- Done
----- Generating ETH wallet
Generating random key pair
Private key: 0f423d7ebb43f28365f786cd12b1babc680ba504d253414e46c6e4599d6d2c9d
Public key:  33c5b61e2adbc283459e06863b57f464dd5fc9394a99e5228a3f0c83310e5c5b1b9c9235e09ec673084c69718b8623152ef66b79f332320f63ba870040604b9b
Address:     0xbc335f1042c6303d094df4548b48558ca400aeaf
----- Done
----- Generating IOTA wallet
Generating random seed
Seed:          DHXXFZGAHINZMVYSGTEM9SK9IRTGUHBVEMAPCR9NQLITWSEXHFXGXDXVXKEJLXVTUYKTIZ9JQZVTKGOZC
First address: HWGUPOHCHLBCSNIBCENHREKGWQCRWGXQ9PRXHOP9DFPZABUMWYVIMPQRAHNMOBLKJLC9RLK9QZXSGVDFCGTN9NQZIW
----- Done
```

## Methods used

### Bitcoin / Ethereum

I used the method and script described in [this excellent article](https://kobl.one/blog/create-full-ethereum-keypair-and-address) from Vincent Kobel. He explaines how to generate an ECDSA keypair with OpenSSL and how to derive the public key into the corresponding address.

I used [this method](https://en.bitcoin.it/wiki/Wallet_import_format) to convert the private key into Wallet Import Format. I used [this technique](https://en.bitcoin.it/wiki/Technical_background_of_version_1_Bitcoin_addresses) to convert the public key into the corresponding Bitcoin address.

### Iota

I used the class _AddressGenerator_ from the official python library [pyota](https://github.com/iotaledger/iota.lib.py).
