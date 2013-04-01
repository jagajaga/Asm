extern printf

section .text
global main

main:
	mov eax, [const]
	movd mm6, [const_]
	movd mm7, eax

	pxor mm2, mm2
	pcmpeqb mm0, mm2
	movq mm1, mm0
	pandn mm1, mm7
	pand mm0, mm6
	paddb mm0, mm1
	movq mm2, mm0	

section .rdata
	const: dq 0xabcdef00
	const_: dq 0xabcdef00
