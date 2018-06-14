import sys, random
from iota import Address
from iota.crypto.types import Seed
from iota.crypto.addresses import AddressGenerator

if len(sys.argv) > 1:
    print('Using', sys.argv[1], 'as seed')
    seed = sys.argv[1]
else:
    print('Generating random seed')
    r = random.SystemRandom()
    trytes = '9ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    seed = ''.join([r.choice(trytes) for _ in range(81)])
    
address = AddressGenerator(seed).get_addresses(0)[0]
print('Seed:         ', Seed(seed))
print('First address:', Address(address).with_valid_checksum())
