extern printf
%define ANSWER_LENGTH 50

section .text
global main

main:
	mov edi, [esp + 8] ;argc[1] ; ORGAN DONOR - DJ SHADOW
	test ebx, ebx
		jz noinput
	xor bx, bx
	jmp get_flags

add_space:
	or bh, 10000b ;bh = space plus minus zero negative ${input sign}
	ret
add_plus:
	or bh, 1000b
	ret
add_minus:
	or bh, 100b
	ret
add_zero:
	or bh, 10b
	ret

get_flags: ;BLACK DOG - LED ZEPPELIN
	mov al, [edi]
	test al, al
		jz get_number
	cmp al, ' '
		je add_space
	cmp al, '+'
		je add_plus
	cmp al, '-'
		je add_minus
	cmp al, '0'
		je add_zero
		jg pre_get_length
	inc edi
	jmp get_flags

pre_get_length: ;Pushin' buttons - Dj Shadow
	xor al, al

get_length: ;COMMUNICATION BREAKDOWN - LED ZEPPELIN
	mov dl, [edi]
	test dl, dl
		jz get_number
	sub dl, '0'
	mov ah, 10
	mul ah
	add al, dl
	mov bl, al ;bl - length
	inc edi
	jmp get_length

get_number: ;














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
