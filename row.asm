extern printf

section .text
global main


main:
	fld qword[number]
	fld1
	fpatan
	call myprint
	mov ecx, 60000000
	jmp arctg

arctg:	
	fld qword[number]
	fld qword[mone]
	fld qword[number]
	fld qword[two]
	fld qword[number]
	fld1
	fld qword[number]

aloop:
	fxch st0, st1
		fadd st0, st3
	fxch st0, st1
	fxch st0, st2
		fmul st0, st4
		fmul st0, st4
		fmul st0, st5
	fxch st0, st2
	fld st2
	fdiv st0, st2
	fxch st0, st7
	fstp st0	
	fadd st0, st6
		
	dec ecx
	jnz aloop

myprint:
	sub esp, 8
	fstp qword[esp]
	push format
	call printf
	add esp, 12
	call print_line
	ret


print_line:
	push new_line
	call printf
	add esp, 4
	ret
	

section .data
	number: dq 0.9999
	format: db "%.20lf"
	new_line: db 10, 0
	two: dq 2.0
	mone: dq -1.0
