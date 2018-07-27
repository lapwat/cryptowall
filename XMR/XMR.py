#!/usr/bin/python3
import random, subprocess
from binascii import hexlify, unhexlify
from ed25519 import publickey
import base58

def sc_reduce32(n):
    n = int.from_bytes(n, 'little')
    l = 2**252 + 27742317777372353535851937790883648493
    reduced = n % l
    newbytes = reduced.to_bytes(32, 'little')
    return newbytes

def keccak(bytes):
    cmd = 'printf {} | ./keccak-256sum -x -l | tr -d \' -\''.format(hexlify(bytes).decode())
    p = subprocess.Popen(cmd, stdout=subprocess.PIPE, shell=True)
    (output, err) = p.communicate()
    p_status = p.wait()
    return unhexlify(output[:-1])

def checksum(bytes):
    return keccak(bytes)[:4]

# generate random private spend key
r = random.SystemRandom()
hex = '0123456789abcdef'
private_spend_key = ''.join([r.choice(hex) for _ in range(64)])
private_spend_key = unhexlify(private_spend_key)

# reduce private spend key
private_spend_key = sc_reduce32(private_spend_key)

# compute and reduce private view key
private_view_key = keccak(private_spend_key)
private_view_key = sc_reduce32(private_view_key)

# compute public keys
public_spend_key = publickey(private_spend_key)
public_view_key = publickey(private_view_key)

# compute address
bytes65 = unhexlify(b'12') + public_spend_key + public_view_key
cs = checksum(bytes65)
bytes69 = bytes65 + cs
address = b''
for i in range(0, 64, 8):
    block = bytes69[i:i+8]
    address += base58.b58encode(block).rjust(11, b'1')
last_block = bytes69[64:69]
address += base58.b58encode(last_block).rjust(7, b'1')

# convert from bytes to hex
private_spend_key = hexlify(private_spend_key)
private_view_key = hexlify(private_view_key)
public_spend_key = hexlify(public_spend_key)
public_view_key = hexlify(public_view_key)

print('Private spend key :', private_spend_key.decode())
print('Private view key  :', private_view_key.decode())
print('Public spend key  :', public_spend_key.decode())
print('Public view key   :', public_view_key.decode())
print('Address           :', address.decode())
