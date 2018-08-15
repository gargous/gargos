#/bin/sh
GOARCH=386
apt install nasm -y &&
nasm -f elf32 kernel.asm -o kasm.o &&
rm entry.o
go tool compile -linkobj entry.l -o entry.o entry.go &&
ld -m elf_i386 -T link.ld -o kernel kasm.o entry.o