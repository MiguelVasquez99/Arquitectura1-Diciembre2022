SYS_INIT_MODULE equ 0x80
SYS_EXIT equ 0x01
SYS_WRITE equ 0x04



section .text
	global _start       
_start:

    mov edx, len
    mov ecx, msg
    mov ebx, 1
    mov eax, 4
    int 0x80
    mov edx, 2
    mov ecx, buf
    mov eax, 3
    mov ebx, 0
    int 0x80
    cmp byte[buf], "1"
    je suma
    cmp byte[buf], "2"
    je resta
    cmp byte[buf], "3"
    je multi
    cmp byte[buf], "4"
    je division
    cmp byte [buf], "5"
    mov esi, 1
    mov ecx, 4
    je potencia
    int 0x80
    
suma:
    mov edx, len_suma
    mov ecx, msg_suma
	mov	eax, 4
	mov	ebx, 1
	int 0x80
	mov eax, 4
	mov ebx, 7
	add eax, ebx
	aam
	add eax, 3030h
	mov ebp, esp
	sub esp, 2
	mov [esp], byte ah
	mov [esp+1], byte al
    mov ecx, esp
    mov edx, 2
    mov ebx, 1
    mov eax, 4
    int 0x80
    mov esp, ebp
    
    
    jmp _start
    
resta:
    mov edx, len_res
    mov ecx, msg_res
	mov	eax, 4
	mov	ebx, 1
	int 0x80
	mov eax, 8
	mov ebx, 2
	sub eax, ebx
	aam
	add eax, 3030h
	mov ebp, esp
	sub esp, 2
	mov [esp], byte ah
	mov [esp+1], byte al
    mov ecx, esp
    mov edx, 2
    mov ebx, 1
    mov eax, 4
    int 0x80
    mov esp, ebp
    
    
    jmp _start
    
multi:
    mov edx, len_multi
    mov ecx, msg_multi
	mov	eax, 3
	mov	ebx, 8
	mul	ebx
	aam
	add eax, 3030h
	mov ebp, esp
	sub esp, 2
	mov [esp], byte ah
	mov [esp+1], byte al
    mov ecx, esp
    mov edx, 2
    mov ebx, 1
    mov eax, 4
    int 0x80
    mov esp, ebp

    
    jmp _start
    
division: 
    mov edx, len_div
    mov ecx, msg_div
    mov eax, 4
    mov ebx, 1
    int 0x80
    mov eax, 40
    mov ebx, 2
    mov edx, 0
    div ebx
    aam
    add eax, 3030h 
    mov ebp, esp
    sub esp, 2
    mov [esp], byte ah
    mov [esp+1], byte al
    mov ecx, esp 
    mov edx, 2
    mov ebx, 1
    mov eax, 4
    int 0x80
    
    jmp _start
    
potencia: 
    ;mov edi, len_pot
    ;mov ecx, msg_pot
    add esi, esi
    dec ecx
    cmp ecx, 0
    jg potencia
    mov eax, 1
    mul esi
    aam
    add eax, 3030h 
    mov ebp, esp
    sub esp, 2
    mov [esp], byte ah
    mov [esp+1], byte al
    mov ecx, esp 
   mov eax, SYS_WRITE
    mov edx, 2
    mov ebx, 1
    int SYS_INIT_MODULE
    mov esp, ebp
    mov eax, SYS_EXIT
    mov ebx,0
    int SYS_INIT_MODULE
    
    jmp _start    
    
    
section .data
msg: db 0Dh, "Esta es una calculadora en Assembler Seleccione" , 0Dh, "1. Suma " , 0Dh, "2. Resta" , 0Dh, "3. Multiplicacion " , 0Dh, "4. Division " , 0Dh, "5. Potencia", 0Dh
len equ $ - msg
msg_suma:db "El resultado de la suma es: "
len_suma equ $ - msg_suma
msg_res: db "El resultado de la resta es: "
len_res equ $ - msg_res
msg_multi: db "El resultado de la multiplicacion es: "
len_multi equ $ - msg_multi
msg_div: db "El resultado de la division es: "
len_div equ $ - msg_div
msg_pot: db "El resultado de la potencia es: "
len_pot equ $ - msg_pot



section .bss
    var1: resb 4
	buf resb 1
