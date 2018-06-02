# Cryptowall
Cryptowall is an **offline** Docker container which generates random crypto wallets. It prints out the private key (or seed) and the corresponding public address to send funds to.

## Usage

```sh
$ docker run --network=none lapwat/cryptowall eth iota
```

## Methods used

### Ethereum / ERC20

I used the method and script described in [this excellent article](https://kobl.one/blog/create-full-ethereum-keypair-and-address) from Vincent Kobel.

### Iota

I used the class _AddressGenerator_ from the official python library [pyota](https://github.com/iotaledger/iota.lib.py).

### Ask for token support

Creating an issue if you want a specific token to be implemeted.
