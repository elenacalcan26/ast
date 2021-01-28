section .data
    delim db " ", 0

section .bss
    root resd 1

section .text

extern check_atoi
extern print_tree_inorder
extern print_tree_preorder
extern evaluate_tree
extern calloc

global create_tree
global iocla_atoi

iocla_atoi: 
    xor eax, eax
    xor ecx, ecx
    mov edi, [ebp + 8]
    mov edi, [edi]
    push ebx
    mov ebx, 1

    cmp byte [edi], '-' ; verific semnul numarului
    jne cast 			; fac jump daca este pozitiv

    mov ebx, -1 		; retin semnul numarului
    inc edi 			; trec pe urmatoarea pozitie a string-ului
    
cast:    
    mov cl, byte [edi]  
    sub ecx, '0' 		; converteste caracterul la int
    
    ; pun valoarea convertita pe pozitia corespunzatoare
    imul eax, 10
    add eax, ecx
    inc edi 				
    
    ; fac jump pana la finalul string-ului
    cmp byte [edi], 0x30
    jge cast

    imul eax, ebx 	; ii atribui numarului convertit semnul corespunzator
	
    pop ebx
    ret

create_node:
	push ebp
	mov ebp, esp
	mov edx, [ebp + 8]

	cmp byte [edi], 0x20 	; verific daca pe pozitia curenta am delimitator
	jne not_delim 		
	inc edi					; am delimitator si trec pe urmatoarea pozitie

not_delim:

	cmp byte [edi], 0x30 	; verific daca pozitia curenta contine un operand  
	jge is_number 		 	

	cmp byte [edi + 1], 0x30 	; verific daca minus este operator sau este semnul unui operand
	jge is_number 				

	; creez nodul in care am operator
	push edx 			; salvez nodul parinte
	push 4
	push 3
	call calloc
	add esp, 8

	pop edx 			; recuperez nodul parinte
	mov [edx], eax 		; leg nodurile
	mov edx, eax 		; mut adresa nodului curent

	push edx 			; salvez nodul curent

	; aloc memorie pentru valoarea nodului
	push 1
	push 1
	call calloc
	add esp, 8
	
	pop edx					; recuperez nodul curent
	mov dword [edx], eax	; pun in nodul curent adresa valorii sale

	; pun operatorul in arbore
	mov cl, byte [edi] 
	mov byte [eax], cl 	
	mov eax, edx 			
	push eax
	inc edi
	
	; apelez recursiv nod stang
	add eax, 4
	push edi
	push eax
	call create_node
	add esp, 8
	pop eax

	; apelez recursiv nod drept
	add eax, 8
	push edi
	push eax
	call create_node
	add esp, 8

	leave
	ret

is_number:
	push edx 	; salvez in stiva nodul parinte
	
	; creez nodul in care am operand
	push 4
	push 3
	call calloc
	add esp, 8
	push eax 	; salvez nodul curent
	
	; aloc memorie pentru valoarea nodului
	push 12
	push 1
	call calloc
	add esp, 8
	
	pop edx 				; recuperez nodul curent
	mov dword [edx], eax 	; pun in nodul curent adresa valorii sale
	push ebx
	xor ebx, ebx

get_number:
	; extrag numarul din string byte cu byte si il pun in nod 
	mov cl, byte [edi]
	mov byte [eax + ebx], cl
	inc edi
	inc ebx

	; fac jump pana cand intalnesc delimitatorul
	cmp byte [edi], 0x30
	jge get_number

	mov eax, edx
	pop ebx
	
	pop edx				; iau inapoi nodul sursa
	mov [edx], eax 		; leg nodurile

return:
	leave
	ret

create_tree:
    enter 0, 0
    xor eax, eax
    
	mov edi, [ebp + 8] 	; iau string-ul citit

	; apelez functia care imi creeaza nodurile arborelui
    push edi
    push root
    call create_node
    add esp, 8
    mov eax, [root]

return_tree:
    leave
    ret