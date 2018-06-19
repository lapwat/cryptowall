# Cryptowall
Cryptowall is an **offline** Docker container which generates random crypto wallets. It prints out the private key, public key, seed or any other usefull info to recover your wallet. It also gives the corresponding address to share in order to receive funds.

Scripts can be found in the folder named after the token. Methods used are described below & sources are given. I tried to use bash scripts where I could to be the most transparent.

## Usage

```sh
$ docker run --network=none lapwat/cryptowall [-p "passphrase"] token...
```

## Example

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

### Bitcoin / Ethereum

[This stackoverflow answer](https://stackoverflow.com/questions/48101258/how-to-convert-an-ecdsa-key-to-pem-format/49213805#49213805) inspired me to generate the public key associated to the private key (ECDSA). You have to import a binary stream _302e0201010420+private_key+a00706052b8104000a_ into openssl.
 
I used the method and script described in [this excellent article](https://kobl.one/blog/create-full-ethereum-keypair-and-address) from Vincent Kobel. He explaines how to generate an ECDSA keypair with OpenSSL and how to derive the public key into the corresponding address.

I used [this method](https://en.bitcoin.it/wiki/Wallet_import_format) to convert the private key into Wallet Import Format. I used [this technique](https://en.bitcoin.it/wiki/Technical_background_of_version_1_Bitcoin_addresses) to convert the public key into the corresponding bitcoin address.

### Iota

I used the class _AddressGenerator_ from the official python library [pyota](https://github.com/iotaledger/iota.lib.py).

### Ask for token support

Creating an issue if you want a specific token to be implemeted.
