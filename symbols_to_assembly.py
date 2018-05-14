#!/usr/bin/env python3

'''\
A simple utility to convert a list of symbols to assembly.
'''

import fileinput
import sys

if __name__ == "__main__":
    for line in fileinput.input():
        line = line.rstrip('\n').split(': ')
        addr = int(line[0], 16)
        label = line[1]
        sys.stdout.write(".global {}\n".format(label))
        sys.stdout.write(".set {}, 0x{:08x}\n".format(label, addr))
