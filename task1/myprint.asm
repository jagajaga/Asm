extern _printf

section .text
global _main

_main:
	mov ebx, [esp + 8]
	mov edi, [ebx + 4] ;argc[1] ; ORGAN DONOR - DJ SHADOW
	test edi, edi
		jz noinput
	mov edi, [ebx + 8] 
	test edi, edi
		jz noflags	
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
	or cl, 0x20
	sub cl, 48
	cmp cl, 9 
		jle pad0 
	sub cl, 39
	pad0:
	and cl, 10000000b
	cmp cl, 10000000b ; Gallows Pole - Led Zeppelidn
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
		jz pre_get_number
	cmp al, '0'
		jg pre_get_length
	cmp al, ' '
		call pre_add_space
	cmp al, '+'
		call pre_add_plus
	cmp al, '-'
		call pre_add_minus
	cmp al, '0'
		call pre_add_zero
	inc edi
	jmp get_flags

pre_get_length: ;Pushin' buttons - Dj Shadow
	xor al, al

get_length: ;COMMUNICATION BREAKDOWN - LED ZEPPELIN
	mov dl, [edi]
	test dl, dl
		jz pre_get_number
	sub dl, '0'
	mov ah, 10
	mul ah
	add al, dl
	mov bl, al ;bl - length
	inc edi
	jmp get_length



check_bite: ;Stairway To Heaven - Led Zeppelin
	mov al, [edi]
	cmp ah, 32
		je pre_add_bite
	test al, al
		jz checking_ret
	inc ah
	inc edi
	jmp check_bite
	
	
checking_ret:
	ret

noflags:
	mov edi, [esp + 8]	
	mov edi, [edi + 4]
	xor ebx, ebx
	jmp pre_get_number_2
	
pre_get_number: ;Dance Dance Dance - Beth Andersen
	mov edi, [esp + 8]	
	mov edi, [edi + 8] ; Flying - The Beatles
pre_get_number_2:
	mov al, [edi]
	cmp al, '-'
		call pre_add_sign
	mov esi, edi
	mov ah, 1
	mov cl, [edi]
	call check_bite
	mov edi, esi
	mov ah, 1
	jmp get_number

get_number: ; Ob-la-di - The Beatles
	xor eax, eax
	xor edx, edx
	mov al, [edi]
	inc edi
	call to_number
	xor ecx, ecx
	mov ecx, 3
	number_loop:
		mov dl, al
		push ebx
			mov bh, 1
			shl bh, cl
			and dl, bh
			shr dl, cl
		pop ebx
		push ebx
			and bh, 1
			xor dl, bh
		pop ebx
		push ecx
			mov ebp, answerend 
			xor ecx, ecx
			xor dh, dh
			call shl_number
			mov ebp, answerend 
			xor ecx, ecx
			xor dh, dh
			call add_to_number
		pop ecx
		loop number_loop


shl_number: ; From me to you - The Beatles
	cmp ch, ah
	call inc_count
	je number_ret
	mov dh, [ebp]
	add dh, dh
	add dh, cl
	xor cl, cl
	cmp dh, 9
	call carry
	mov [ebp], dh
	dec ebp
	inc ch
	jmp shl_number

add_to_number:
	cmp ch, ah
	call inc_count
	je number_ret
	cmp cl, 1
		je atn1
	cmp ch, 0
		je atn1
	ret
atn1:
	mov dh, [ebp]
	add dh, dl
	add dh, cl
	xor cl, cl
	cmp dh, 9
	call carry
	mov [ebp], dh
	dec ebp
	inc ch
	jmp add_to_number


inc_count:
	jne number_ret
	cmp cl, 0
		je number_ret
	inc ah
	mov [ebp], byte(1)
	cmp ah, ah
	ret

carry:
	jle number_ret
	inc cl
	sub dh, 10
	ret

to_number: ;Sunshine Superman - Donovan
	or al, 0x20
	sub al, 48
	cmp al, 9 
		jle number_ret 
	sub al, 39
	ret

number_ret:
	ret















noinput:
	push noinputstring
	push formats
	call _printf
	add esp, 8
	call exit
	ret
exit:
	ret
section .rodata
    formatc: db "%c", 0
	formats: db "%s", 0
    formatd: db "%d", 0
	noinputstring: db "No input", 10, 0
section .data
	answer: times 50 db 0
	answerend: db 0

end
