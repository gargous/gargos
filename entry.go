package main

import (
	"unsafe"
)

func kmain() {
	str := []rune("my first kernel")
	vidptr := 0xb8000
	for i := 0; i < 80*25*2; i += 2 {
		*(*rune)(unsafe.Pointer(uintptr(vidptr + i))) = ' '
		*(*rune)(unsafe.Pointer(uintptr(vidptr + i + 1))) = 0x07
	}
	j := 0
	for i := 0; i < len(str); i++ {
		*(*rune)(unsafe.Pointer(uintptr(vidptr + j))) = str[i]
		*(*rune)(unsafe.Pointer(uintptr(vidptr + j + 1))) = 0x07
		j = j + 2
	}
}
