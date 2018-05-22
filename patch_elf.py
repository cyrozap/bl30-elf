#!/usr/bin/env python3

'''\
Patch the section indices in the symbol table.
'''


import argparse
import struct


def patch(data):
    patched = bytearray(data)

    offset = 16+2+2+4+4+4
    e_shoff = struct.unpack_from('<I', data, offset)[0]
    offset += 4+4+2+2+2
    e_shentsize = struct.unpack_from('<H', data, offset)[0]
    offset += 2
    e_shnum = struct.unpack_from('<H', data, offset)[0]

    for i in range(e_shoff, e_shoff+e_shentsize*e_shnum, e_shentsize):
        sh_type = struct.unpack_from('<I', data, i+4)[0]
        sh_offset = struct.unpack_from('<I', data, i+16)[0]
        sh_size = struct.unpack_from('<I', data, i+20)[0]
        if sh_type == 2:
            break

    for i in range(sh_offset, sh_offset+sh_size, 16):
        st_info = struct.unpack_from('B', data, i+12)[0]
        st_type = st_info & 0xf
        if st_type == 2:
            struct.pack_into('<H', patched, i+14, 1)

    return patched

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("input", type=str, help="Input file.")
    parser.add_argument("-o", "--output", type=str, default="output.elf", help="Output file.")
    args = parser.parse_args()

    binary = open(args.input, 'rb').read()
    patched = patch(binary)
    output = open(args.output, 'wb')
    output.write(patched)
    output.close()
