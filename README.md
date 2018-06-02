# Cryptowall
Cryptowall is an **offline** Docker container which generates random crypto wallets. It prints out the private key (or seed) and the corresponding public address to send funds to.

## Usage

```sh
$ docker run --network=none lapwat/cryptowall eth iota
----- Generating ETH wallet
Private key: 073026f2007252ec0c757e2b267f0b520c4c43032c99a87e85682142a7a779f5
Public key:  26405a664d431174a62d70e931fae82c676e32bac01ad1de2e549935d21570dab6d6afe3f1f76f9e68d80a05322f62619b43676a4c8536039e8fe31a381d3653
Address:     0x69fe87a6b659058a9ee41afe78a3acc20c2fc1e7
----- Done
----- Generating IOTA wallet
Seed:          USSUSTKGIKBMARJPQOIEXHWHVPEWOLM9ASZFZAOWMCDXKENQXFFLUONQRTSIQVZATSFPN9Y9ZJEUVWSOP
First address: OSVPRVP9FGXNMLNQGWWKBSBZ9LYLYEUIHLNJYGTRJDSCXRIJBDZOAZMOXWUAWCEZYGSLJWZBLPKOFRKSXLZQCEYKDX
----- Done
```

## Methods used

### Ethereum / ERC20

I used the method and script described in [this excellent article](https://kobl.one/blog/create-full-ethereum-keypair-and-address) from Vincent Kobel.

### Iota

I used the class _AddressGenerator_ from the official python library [pyota](https://github.com/iotaledger/iota.lib.py).

### Ask for token support

Creating an issue if you want a specific token to be implemeted.
