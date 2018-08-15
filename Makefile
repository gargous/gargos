GCCGO := gccgo
GCC := gcc
NASM := nasm
QEMU := qemu

default: build

build: bootgo.bin

bootgo.bin: boot.o kernel.o
	$(GCC) -T linker.ld -o bootgo.bin -ffreestanding -nostdlib boot.o kernel.o -lgcc

boot.o: boot.asm
	$(NASM) -felf32 boot.asm -o boot.o

kernel.o: kernel.go
	$(GCCGO) -c kernel.go -fgo-prefix=bootgo

run-qemu:
	$(QEMU) -kernel bootgo.bin

clean:
	rm -f *.o
	rm -f **/*.so
	rm -f *.bin