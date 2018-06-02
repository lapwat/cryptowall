import random
from iota.crypto.addresses import AddressGenerator

r = random.SystemRandom()
trytes = '9ABCDEFGHIJKLMNOPQRSTUVWXYZ'
seed = ''.join([r.choice(trytes) for _ in range(81)])
address = AddressGenerator(seed).get_addresses(0)[0]
print('Seed:         ', seed)
print('First address:', address)
