;
; Program: exit
;
; Executes the exit system call
;
; No input
;
; Output: Only the exit status ($? in the shell)
;
    segment .text
    global  main

main:
    mov eax, 60 ; 60 is the exit syscall number
    mov edi,  0 ; the status value to return
    syscall     ; execute the system call number stored in eax
    end
