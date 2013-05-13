section .text

global _fdct
global _idct

mul_a_b_c_to_d_matrix:  
mov cl, 8
movups xmm3, [zero]
mov eax, [esp + 4]
mov esi, temp_matrix
mul_l1:
movaps xmm0, xmm3
mov ebx, [esp + 8]
mov ch, 8
mul_l1_l1:
movss xmm1, [eax]
shufps xmm1, xmm1, 0
movaps xmm2, [ebx]
mulps xmm1, xmm2
addps xmm0, xmm1
add eax, 4
add ebx, 32
dec ch
jnz mul_l1_l1
movaps [esi], xmm0
sub eax, 32
movaps xmm0, xmm3
mov ebx, [esp + 8]
mov ch, 8
mul_l1_l2:
movss xmm1, [eax]
shufps xmm1, xmm1, 0
movaps xmm2, [ebx + 16]
mulps xmm1, xmm2
addps xmm0, xmm1
add eax, 4
add ebx, 32
dec ch
jnz mul_l1_l2
movaps [esi + 16], xmm0
add esi, 32
dec cl
jnz mul_l1

mov cl, 8
movups xmm3, [zero]
mov eax, temp_matrix
mov edx, [esp + 16]
mul_l2:
movaps xmm0, xmm3
mov ebx, [esp + 12]
mov ch, 8
mul_l2_l1:
movss xmm1, [eax]
shufps xmm1, xmm1, 0
movaps xmm2, [ebx]
mulps xmm1, xmm2
addps xmm0, xmm1
add eax, 4
add ebx, 32
dec ch
jnz mul_l2_l1
movaps [edx], xmm0
sub eax, 32
movaps xmm0, xmm3
mov ebx, [esp + 12]
mov ch, 8
mul_l2_l2:
movss xmm1, [eax]
shufps xmm1, xmm1, 0
movaps xmm2, [ebx + 16]
mulps xmm1, xmm2
addps xmm0, xmm1
add eax, 4
add ebx, 32
dec ch
jnz mul_l2_l2
movaps [edx + 16], xmm0
add edx, 32
dec cl
jnz mul_l2
ret

_fdct:
mov eax, [esp + 4]
mov ebx, [esp + 8]
mov edx, [esp + 12]
loop_main:
push eax
push ebx
push edx
push ebx
push tdct_const_matrix
push eax
push dct_const_matrix
call mul_a_b_c_to_d_matrix
add esp, 16
pop edx
pop ebx
pop eax
add eax, 256
add ebx, 256
dec edx
jnz loop_main
ret

_idct:  
mov eax, [esp + 4]
mov ebx, [esp + 8]
mov edx, [esp + 12]
loop_main2:
push eax
push ebx
push edx
push ebx
push dct_const_matrix 
push eax
push tdct_const_matrix 
call mul_a_b_c_to_d_matrix
add esp, 16
pop edx
pop ebx
pop eax
push eax
push ebx
push edx
mov eax, ebx
mov cl, 16
movups xmm0, [sixty_four]
mul_by64_l1:
movaps xmm1, [eax]
mulps xmm1, xmm0
movaps [eax], xmm1
add eax, 16
dec cl
jnz mul_by64_l1
pop edx
pop ebx
pop eax
add eax, 256
add ebx, 256
dec edx
jnz loop_main2
ret

section .data
	align 16
	zero: dd 0.0, 0.0, 0.0, 0.0

	align 16
	sixty_four: dd 64.0, 64.0, 64.0, 64.0

	align 16
	dct_const_matrix: dd 0.12500000, 0.12500000, 0.12500000, 0.12500000, 0.12500000, 0.12500000, 0.12500000, 0.12500000, 0.17337997, 0.14698444, 0.09821186, 0.03448742, -0.03448743, -0.09821188, -0.14698446, -0.17337999, 0.16332036, 0.06764951, -0.06764952, -0.16332038, -0.16332036, -0.06764949, 0.06764954, 0.16332039, 0.14698444, -0.03448743, -0.17337999, -0.09821185, 0.09821189, 0.17337997, 0.03448739, -0.14698447, 0.12500000, -0.12500001, -0.12499999, 0.12500001, 0.12499998, -0.12500003, -0.12499996, 0.12500004, 0.09821186, -0.17337999, 0.03448744, 0.14698444, -0.14698447, -0.03448737, 0.17337996, -0.09821194, 0.06764951, -0.16332036, 0.16332039, -0.06764955, -0.06764946, 0.16332035, -0.16332039, 0.06764959, 0.03448742, -0.09821185, 0.14698444, -0.17337997, 0.17338000, -0.14698449, 0.09821194, -0.03448752 ;hardcoded cos transf matrix

	align 16
	tdct_const_matrix: dd 0.12500000, 0.17337997, 0.16332036, 0.14698444, 0.12500000, 0.09821186, 0.06764951, 0.03448742, 0.12500000, 0.14698444, 0.06764951, -0.03448743, -0.12500001, -0.17337999, -0.16332036, -0.09821185, 0.12500000, 0.09821186, -0.06764952, -0.17337999, -0.12499999, 0.03448744, 0.16332039, 0.14698444, 0.12500000, 0.03448742, -0.16332038, -0.09821185, 0.12500001, 0.14698444, -0.06764955, -0.17337997, 0.12500000, -0.03448743, -0.16332036, 0.09821189, 0.12499998, -0.14698447, -0.06764946, 0.17338000, 0.12500000, -0.09821188, -0.06764949, 0.17337997, -0.12500003, -0.03448737, 0.16332035, -0.14698449, 0.12500000, -0.14698446, 0.06764954, 0.03448739, -0.12499996, 0.17337996, -0.16332039, 0.09821194, 0.12500000, -0.17337999, 0.16332039, -0.14698447, 0.12500004, -0.09821194, 0.06764959, -0.03448752 ;hardcoded cos transposed transf matrix

	align 16
	temp_matrix: resd 64
