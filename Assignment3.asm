; Find the largest of given numbers.
;Write an X86/64 ALP to find the largest of given Byte/Word/Dword/64-bit numbers.

section .data

	%macro write 2
	mov rax,1
	mov rdi,1
	mov rsi,%1
	mov rdx,%2
	syscall
	%endmacro

	array db 10h,20h,30h,40h,70h

	msg1 db 10,"ALP to find the largest of the given no. in an array",10,13
	len1 equ $-msg1

	msg2 db 10,"The contents of the array are : ",10,13
	len2 equ $-msg2

	msg3 db 10,"The largest no. from the array is : ",10,13
	len3 equ $-msg3

	space db 10," "

	newline db 10," "

	
	

section .bss

	counter resb 1
	result resb 4


section .txt

global _start

_start:
	write msg1,len1
	write msg2,len2

	mov byte[counter],05
	mov rsi,array

	next:
		mov al,[rsi]
		push rsi
		call disp
		write space,1
		pop rsi
		inc rsi
		dec byte[counter]
		jnz next

	write msg3,len3

	mov byte[counter],05
	mov rsi,array
	mov al,0
	
	repeat:
		cmp al,[rsi]
		jg skip
		mov al,[rsi]

	skip:
		inc rsi
		dec byte[counter]
		jnz repeat
		
	call disp
	
	exit:
		mov rax,60
		mov rdi,0
		syscall

	disp:
		mov bl,al
		mov rdi,result
		mov cx,02

	up1:
		rol bl,04
		mov al,bl
		and al,0fh
		cmp al,09h
		jg add_37
		add al,30h
		jmp skip1

	add_37:
		add al,37h

	skip1:
		mov [rdi],al
		inc rdi
		dec cx
		jnz up1
		write result,02
		write newline,02

		ret
