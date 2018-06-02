import random
from iota.crypto.addresses import AddressGenerator

trytes = '9ABCDEFGHIJKLMNOPQRSTUVWXYZ'
r = random.SystemRandom()
seed = ''.join([r.choice(trytes) for _ in range(81)])
generator = AddressGenerator(seed)
address = generator.get_addresses(0)[0]
print('Seed:', seed)
print('First address:', address)
