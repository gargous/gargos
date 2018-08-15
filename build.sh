#/bin/sh
apt install nasm -y
nasm -f elf32 kernel.asm -o kasm.o
go tool compile -S entry.go
ld -m elf_i386 -T link.ld -o kernel kasm.o entry.o