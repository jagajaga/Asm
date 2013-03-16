extern printf
%define ANSWER_LENGTH 50

section .text
global main

main:
	mov edi, [esp + 8] ;argc[1]
	test ebx, ebx
		jz noinput
	xor bh, bh
	jmp get_flags

;bh = space plus minus zero negative
add_space:
	or bh, 10000b
add_plus:
	or bh, 1000b
add_minus:
	or bh, 100b
add_zero:
	or bh, 10b

get_flags:
	mov al, [edi]
	test al, al
		jz get_length
	cmp al, ' '
		je add_space
	cmp al, '+'
		je add_plus
	cmp al, '-'
		je add_minus
	cmp al, '0'
		je add_zero
	inc edi
	jmp get_flags














noinput:
	push noinputstring
	push formats
	call printf
	add esp, 8
	call exit
	
exit:

section .rodata
    formatc: db "%c", 0
    formats: db "%s", 0
	noinputstring: db "No input", 10, 0
section .data
	answer: times ANSWER_LENGTH db 0
	answerend: db 0

end
