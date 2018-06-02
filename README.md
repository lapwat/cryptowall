# Cryptowall
Cryptowall is a crypto wallet generator. This tool is an **offline** Docker container which generates random crypto wallets.

## Usage

```sh
$ docker run --network=none lapwat/cryptowall iota eth
```

## Methods used

### Ethereum / ERC20

I used the method and script described in [this excellent article](https://kobl.one/blog/create-full-ethereum-keypair-and-address).

### Iota

I used the official python library [pyota](https://github.com/iotaledger/iota.lib.py).

### Ask for token support

Creating an issue if you want a specific token to be implemeted.
