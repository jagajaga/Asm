extern printf
%define ANSWER_LENGTH 50

section .text
global main

main:
	mov edi, [esp + 8] 
	mov edi, [edi + 4] ;argc[1] ; ORGAN DONOR - DJ SHADOW
	test edi, edi
		jz noinput
	xor ebx, ebx
	jmp get_flags


pre_add_space:
	je add_space
	ret
pre_add_plus:
	je add_plus
	ret
pre_add_minus:
	je add_minus
	ret
pre_add_zero:
	je add_zero
	ret
pre_add_sign:
	je add_sign
	ret
pre_add_bite:
	je add_bite
	ret

add_space:
	or bh, 100000b ;bh = space plus minus zero negative ${input sign} ${input_bite}
	ret
add_plus:
	or bh, 10000b
	ret
add_minus:
	or bh, 1000b
	ret
add_zero:
	or bh, 100b
	ret
add_sign:
	inc edi
	or bh, 10b
	ret
add_bite:
	or bh, 1b
	ret

get_flags: ;BLACK DOG - LED ZEPPELIN
	mov al, [edi]
	test al, al
		jz get_number
	cmp al, ' '
		call add_space
	cmp al, '+'
		call add_plus
	cmp al, '-'
		call add_minus
	cmp al, '0'
		call add_zero
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

check_bite:
	mov al, [edi]
	test al, al
		jz ret
	cmp ah, 32
		je ret
	
	


get_number: ;Dance Dance Dance - Beth Andersen
	mov edi, [esp + 8]	
	mov edi, [edi + 8] ; Flying - The Beatles
	mov al, [edi]
	cmp al, '-'
		je add_sign
	call check_bite














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
