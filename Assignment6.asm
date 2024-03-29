;Program to switch from real mode to protected mode and display the values of GDTR,LDTR,IDTR,TR and MSW Registers.

;Write X86/64 ALP to detect protected mode and display the values of GDTR, LDTR, IDTR, TR and MSW Registers also identify CPU type using CPUID instruction.


section .data

          %macro print 2
          mov rax,1
          mov rdi,1
          mov rsi,%1
          mov rdx,%2
          syscall
          %endmacro
          

          rmodemsg db 10,"The processor is in Real Mode"
          len1 equ $-rmodemsg
          
          pmodmsg db 10,"The processor is in Protected Mode"
          len2 equ $-pmodmsg
          
          gdtmsg db 10,"The contents of GDTR are -> "
          len3 equ $-gdtmsg
          
          ldtmsg db 10,"The contents of LDTR are -> "
          len4 equ $-ldtmsg
          
          idtmsg db 10,"The contents of IDTR are -> "
          len5 equ $-idtmsg
          
          trmsg db 10,"The contents of Task Register are -> "
          len6 equ $-trmsg
          
          mswmsg db 10,"The contents of MSW are -> "
          len7 equ $-mswmsg
          
          colmsg db ':'
          
          newline db 10
          
          
section .bss
          
          gdt resd 1
              resw 1
              
          ldt resw 1
          
          idt resd 1
              resw 1
              
          tr resw 1
          
          cr0_data resd 1
          
          dnum_buff resb 04
          
          
section .txt

global _start

          _start:
                    smsw eax  ; store msw, also as MSW is 32 bit so we used eax
                    
                    mov [cr0_data],eax
                    
                    bt eax,0  ;checking PE bit 
                              ; if 1 then Protected Mode ,else it is in Real mode
                              
                    jc prmode ; if 1
                    print rmodemsg,len1
                    jmp nxt1
                    
          prmode:
                    print pmodmsg,len2
                    
          nxt1:
                    sgdt [gdt]
                    sldt [ldt]
                    sidt [idt]
                    str [tr]
                    
          print gdtmsg,len3
          
                    mov bx,[gdt+4]
                    call print_num
                    
                    mov bx,[gdt+2]
                    call print_num
                    
                    print colmsg,1
                    
                    mov bx,[gdt]
                    call print_num
                    
          print ldtmsg,len4
          
                    mov bx,[ldt]
                    call print_num
                    
          print idtmsg,len5
          
                    mov bx,[idt+4]
                    call print_num
                    
                    mov bx,[idt+2]
                    call print_num
                    
                    print colmsg,1
                    
                    mov bx,[idt]
                    call print_num
                    
          print trmsg,len6
          
                    mov bx,[tr]
                    call print_num
                    
          print mswmsg,len7
          
                    mov bx,[cr0_data+2]
                    call print_num
                    
                    mov bx,[cr0_data]
                    call print_num
                    
          print newline,1
          
          exit:
                    mov rax,60
                    xor rdi,rdi
                    syscall
                    
          print_num:
                    mov rsi,dnum_buff
                    mov rcx,04
                    
          up1:
                    rol bx,4
                    mov dl,bl
                    and dl,0fh
                    add dl,30h
                    cmp dl,39h
                    jbe skip1
                    add dl,07h
                    
          skip1:
                    mov [rsi],dl
                    inc rsi
                    loop up1
                    
                    print dnum_buff,4
                    
                    ret
                               
