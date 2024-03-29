;Multiplication by successive addition


section .data
    %macro print 2
        mov rax,1
        mov rdi,1
        mov rsi,%1
        mov rdx,%2
        syscall
    %endmacro
    
    %macro accept 2
        mov rax,0
        mov rdi,0
        mov rsi,%1
        mov rdx,%2
        syscall
    %endmacro
    
    
    msg1 db 10,13,"Program to Multiply two nos. using successive addition !",13
    len1 equ $-msg1
    
    msg2 db 10,13,"MENU",13,"1.Perform Addition",13,"Exit"
    len2 equ $-msg2
    
    msg3 db 10,"Enter the 2-Digit Multiplicand (HexaDecimal No.) : "
    len3 equ $-msg3
    
    msg4 db 10,"Enter the 2-Digit Multiplier (HexaDecimal No.) : "
    len4 equ $-msg4
    
    msg5 db 10,"The Multiplication of the 2 nos. is :"
    len5 equ $-msg5
    
    msg6 db 10,13,"Exiting from the Program...............",13
    len6 equ $-msg6
    
    newline db 10," "
    nline equ $-newline
    
section .bss
    mcand resb 02
    mplier resb 02
    choice resb 02
    numascii resb 04
    dispbuff resb 02


section .text
    global _start

_start:
    print msg1,len1
    
    print msg2,len2
    
    accept choice,02
    
    cmp byte[choice],"1"
    je add
    
    cmp byte[choice],32
    je exit
    
    add:
        print msg3,len3
        accept numascii,03
        call ascii2num
        mov [mcand],bl
        
        print msg4,len4
        accept numascii,03
        call ascii2num
        mov [mplier],bl
        
    print msg5,len5
    
    mov rax,0
    cmp byte[mplier],0
    jz l15
    
    l11:
        add rax,[mcand]
        dec byte[mplier]
        jnz l11
        
    l15:
        call display
        
    exit:
        print msg6,len6
        mov rax, 60
        mov rdi, 0
        syscall
        
    ascii2num:
        mov bl,0
        mov rcx,02
        mov rsi,numascii
        
    up1:
        rol bl,04
        mov al,[rsi]
        cmp al,39h
        jbe skip1
        sub al,07h
        
    skip1:
        sub al,30h
        add bl,al
        inc rsi
        loop up1
        ret
        
    display:
        mov rdi,dispbuff
        mov rcx,02
        
    up2:    
        rol al,04
        mov dl,al
        and dl,0fh
        add dl,30h
        cmp dl,39h
        jbe dispskip1
        add dl,07h
        
    dispskip1:
        mov [rdi],dl
        inc rdi
        loop up2
        print dispbuff,2
        ret    
