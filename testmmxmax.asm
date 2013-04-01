section .text
global main

main:
	psubusb mm0, mm1
	paddb mm0, mm1

section r.data
	const32: dq 32
