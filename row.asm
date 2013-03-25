extern printf

section .text
global main


main:
	jmp arctg



arctg:
	fld qword[number]
	fsqrt
	sub esp, 8
	fstp qword[esp]
	push format
	call printf
	add esp, 12
	ret
	

section .data
	number: dq 0.11
	format: db "%lf"

