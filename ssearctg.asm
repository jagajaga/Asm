extern printf

section .text
global main

main:
	movsd xmm0, [number]
	movsd xmm1, [one]
	movsd xmm2, [number]
	mulsd xmm2, [number]
	movsd xmm3, [number]
	mulsd xmm2, [mone]
	mov ecx, 60000000

for:
	addsd xmm1, [two]
	mulsd xmm3, xmm2
	movsd xmm4, xmm3
	divsd xmm4, xmm1
	addsd xmm0, xmm4
	
	dec ecx
	jnz for


myprint:
	sub esp, 8
	movsd qword[esp], xmm0
	push format
	call printf
	add esp, 12
	xor eax, eax
	ret

section .data
	number: dq 0.9999
	one: dq 1.0
	two: dq 2.0	
	mone: dq -1.0
	format: db "%.20lf", 0
