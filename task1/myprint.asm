extern printf
%define ANSWER_LENGTH 50

section .text
global main

main:
	mov ecx, [esp + 4] ;argc
	mov ebx, [esp + 8] ;argv
	mov ebx, [ebx + 4] ;argv[1]
	test ebx, ebx
		jz noinput
	push dword[ebx]
	push formatc
	jmp print
noinput:
	push noinputstring
	push formats
print:
	call printf
	add esp, 8
	

section .rodata
    formatc: db "%c", 0
    formats: db "%s", 0
	noinputstring: db "No input", 10, 0
section .data
	answer: times ANSWER_LENGTH db 0
	answerend: db 0

end
