import struct

hex_num = "4043b32b020c49ba"
float_num = struct.unpack('!d', bytes.fromhex(hex_num))[0]

print(float_num)