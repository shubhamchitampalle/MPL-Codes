;Non-Overlapped block data transfer
;Write X86/64 ALP to perform non-overlapped block transfer without string specific instructions. Block containing data can be defined in the data segment.

section .data

%macro write 2
mov rax,1
mov rdi,1
mov rsi,%1
mov rdx,%2
syscall
%endmacro

m1 db 10,"ALP to perform Non-overlapped Block Data transfer without string related instructions",10
l1 equ $-m1

m2 db 10,"Source Block contents before transfer are : ",10
l2 equ $-m2 

m3 db 10,"Destination Block contents after tranfer are : ",10
l3 equ $-m3

srcblk db 10h,20h,30h,40h,50h
;dstblk db 00,00,00,00,00

newline db 10

space db 10," "
spacelen equ $-space

cnt equ 05


section .bss

ans resb 02
dstblk resb 05



section .txt

global _start:
_start:

write m1,l1
write space,01
write m2,l2

mov rsi,srcblk
call display

write m3,l3
mov rsi,srcblk
mov rdi,dstblk
mov rcx,05

again:
          mov al,[rsi]
          mov [rdi],al
          inc rsi
          inc rdi
          loop again
          
mov rsi,dstblk
call display

exit:
mov rax,60
mov rdi,0
syscall

display:
          mov rbp,cnt
          back:
          mov al,[rsi]
          push rsi
          call disp_8
          write space,1
          pop rsi
          inc rsi
          dec rbp
          jnz back
          ret
          
disp_8:
          mov rdi,ans
          mov rcx,02
          up1:
                    rol al,4
                    mov dl,al
                    and dl,0fh
                    add dl,30h
                    cmp dl,39h
                    jbe dispskip1
                    add dl,07h
dispskip1:  
          mov [rdi],dl
          inc rdi
          loop up1
          write ans,2
          
          ret
