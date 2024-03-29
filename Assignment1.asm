;Display Accepted Numbers
;Write an X86/64 ALP to accept five 64 bit Hexadecimal numbers from user and store them in an array and display the accepted numbers
section .data

title db 10,"This is the code for checking the count of positive and negative nos.",10
l1 equ $-title

mesg1 db 10,"The positive nos. are : ",10
l2 equ $-mesg1

mesg2 db 10,"The negative nos. are : ",10
l3 equ $-mesg2

%macro print 2
mov rax,1
mov rdi,1
mov rsi,%1
mov rdx,%2
syscall
%endmacro

array dq -1234h,3435h,356h,32A32h,3546h,748h,-746bh

pcnt db 0
ncnt db 0
newline db 10


section .bss

dispbuff resb 2

section .txt

global _start:
_start:

print title,l1

mov rsi,array
mov rcx,07

again:
		bt qword[rsi],63
		jnc pnxt
		inc byte[ncnt]
		jmp pskip
	pnxt: inc byte[pcnt]
	pskip: add rsi,8

loop again

print mesg1,l2
mov bl,[pcnt]
call again1

print newline,1

print mesg2,l3
mov bl,[ncnt]
call again1

print newline,1

mov rax,60
mov rdi,0
syscall

again1:
		mov rdi,dispbuff
		mov rcx,02
	dispup1:
		rol bl,4
		mov dl,bl
		and dl,0fh
		add dl,30h
		cmp dl,39h
		jbe dispskip1
		add dl,07h

	dispskip1:
		mov [rdi],dl
		inc rdi
		loop dispup1
		print dispbuff,2

	ret
