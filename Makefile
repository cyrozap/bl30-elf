AS := arm-none-eabi-as
ASFLAGS := -mcpu=cortex-m3
CC := arm-none-eabi-gcc
CFLAGS := -mcpu=cortex-m3 -static -nostdlib

all: bl30.elf

bl30.elf: bl30.o rodata.o sram.o symbols.o
	$(CC) $(CFLAGS) -T ./linker.ld -o $@ $^

%.o: %.s %.bin
	$(AS) $(ASFLAGS) -o $@ $<

symbols.s: symbols.txt symbols_to_assembly.py
	./symbols_to_assembly.py $< > $@

bl30.bin: bl30-orig.bin
	dd if=$< of=$@ bs=1 count=23212

rodata.bin: bl30-orig.bin
	dd if=$< of=$@ bs=1 skip=23212 count=9556

sram.bin: bl30-orig.bin
	dd if=$< of=$@ bs=1 skip=32768

bl30-orig.bin:
	curl -o $@ https://raw.githubusercontent.com/hardkernel/u-boot/e6d835ab9d1e1ead15d019a97f1201effd081988/fip/gxb/bl30.bin

clean:
	rm -f *.elf *.o *.bin

.PHONY: all clean
