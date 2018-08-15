GCCGO := gccgo
GCC := gcc
NASM := nasm
QEMU := qemu

default: build

build: bootgo.bin

bootgo.bin: boot.o entry.o
	$(GCC) -T link.ld -o bootgo.bin -ffreestanding -nostdlib boot.o entry.o -lgcc

boot.o: boot.asm
	$(NASM) -felf32 boot.asm -o boot.o

entry.o: entry.go
	$(GCCGO) -c entry.go -fgo-prefix=bootgo

run-qemu:
	$(QEMU) -kernel bootgo.bin

clean:
	rm -f *.o
	rm -f **/*.so
	rm -f *.bin