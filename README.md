# bl30-elf

A makefile, a linker script, and some assembly that builds an ELF file from
Amlogic's S905 `bl30.bin` that can be easily loaded by most dissasemblers that
support the ARMv7-M instruction set.

I wouldn't have been able or even had the idea to do this without
[this blog post][1].

## Dependencies

* [arm-none-eabi-gcc][2] (It might be available through your package manager)
* [curl][3]
* [make][4]

## Usage

Clone this repository, then `cd` to it and run `make`. The firmware will be
downloaded, split, and linked into an ELF.

[1]: http://grangeia.io/2015/11/30/hacking-tomtom-runner-pt3/#runtime-debugging-with-qemu
[2]: https://launchpad.net/gcc-arm-embedded
[3]: https://curl.haxx.se/
[4]: https://www.gnu.org/software/make/
