TITLE Sorting Random Integers     (program4.asm)

; Author: Genevieve Conty
; Last Modified: 08/05/2019
; OSU email address: contyg@oregonstate.edu
; Course number/section: CS271-400
; Assignment Number: Program #4                Due Date: 08/04/2019
; Description: Generates random numbers in the range [100 .. 999], display them, 
; calculate median, sort the numbers and display the sorted list in descending order. 

INCLUDE Irvine32.inc

; ---------------------------------------------
; constant definitions
; ---------------------------------------------

MIN = 15
MAX = 200
LO = 100
HI = 999
MAX_PER_LINE = 9

.data

; intro prompts
programTitle    BYTE    "Sorting Random Integers",0
author          BYTE    "Programmed by Genevieve Conty",0
description     BYTE    "This program generates random numbers in the range [100 .. 999], displays the original list, sorts the list, and calculates the median value. Finally, it displays the list sorted in descending order.",0

; input and result prompts
inputPrompt     BYTE    "How many numbers should be generated? [15 .. 200]: ",0
unsortedPrompt  BYTE    "The unsorted random numbers: ",0
medianPrompt    BYTE    "The median is ",0
sortedPrompt    BYTE    "The sorted list:",0

; error prompt
invalidMsg      BYTE    "Invalid input",0

; goodbye prompt
byeMsg       BYTE    "Thanks for using my program!",0

; variables
range           DWORD   ?               ; randomly generated range
numArr          DWORD   MAX DUP(?)      ; array for random numbers, as big as MAX
numsToGenerate  DWORD   ?               ; user input, how many numbers to be generated
spaces          BYTE    "     ",0       ; 5 spaces
lineIndex		DWORD	0

.code
main PROC
    
    call	RANDOMIZE                   ; need to call at the begining of the prog
    call    introduction
 
    ; push ref to numsToGenerate onto stack (esp)
    push    OFFSET numsToGenerate       
    call    getData

    ; put fillArray params into stack
    push    numsToGenerate
    push    OFFSET numArr               ; STACK: @numArr, numsTroGenerate 
    call    fillArray                   ; fill with random numbers

    ; display unsorted numbers
    push    numsToGenerate
    push    OFFSET numArr
    push    OFFSET unsortedPrompt
    call    displayList                 ; STACK: @ret, @unsortedPrompt, @numArr, numsTroGenerate

    ; calculate and display median
    push    numsToGenerate
    push    OFFSET numArr
    push    OFFSET medianPrompt
    call    displayMedian               ; STACK: @ret, @medianPrompt, @numArr, numsTroGenerate

    push    numsToGenerate
    push    OFFSET numArr   
    call    sortArray                   ; STACK: @ret, @numArr, numsTroGenerate
    
    ; display sorted numbers
    push    numsToGenerate
    push    OFFSET numArr
    push    OFFSET sortedPrompt        ; STACK: @ret, @sortedPrompt, @numArr, numsTroGenerate
    call    displayList

	exit	; exit to operating system
main ENDP

; NAME: introduction
; description: Displays introduction, program title and program description. 
; parameters (in stack order): none
; returns: n/a
; preconditions: n/a
; registers changed: edx
introduction PROC
    mov     edx, OFFSET programTitle
    call    WriteString
    call    CrLf

    mov     edx, OFFSET author
    call    WriteString
    call    CrLf

    mov     edx, OFFSET description
    call    WriteString
    call    CrLf

introduction ENDP

; NAME: getData
; description: Display input prompt, ensure user's input is within MIN and MAX, 
;   gets how many numbers the user wants to generate
; parameters (in stack order): numsToGenerate (by reference),  MIN (global constant),
;   MAX (global constant)
; returns: number of integers to be generated
; preconditions: none
; registers changed: ebp, ebx, esp, edx, eax
getData PROC

    ; set up stack
    push    ebp             
    mov     ebp, esp
    mov     ebx, [ebp+8]        ; put @numsToGenerate ref into EBX
    ; STACK: ebp, ret@, @numsToGen

    ; --------------------------------------------
    ; Get input from user. Check that user input 
    ; is between MAX and MIN. 
    ; --------------------------------------------
    inputLopp:
        mov		edx, OFFSET inputPrompt
        call	WriteString
        call	ReadInt

        ; validate that user input is between MIN/MAX
        cmp		eax, MAX		    ; if input > MAX
        jg		displayErrorMsg		
        cmp		eax, MIN		    ; if input < MIN
        jl		displayErrorMsg
        jmp		valid

    ; --------------------------------------------
    ; Display error message for failed validation
    ; --------------------------------------------
    displayErrorMsg:
        mov		edx, OFFSET invalidMsg
        call	WriteString
        call	CrLf
        jmp		inputLoop       ; loop back to top of inputLoop

    ; --------------------------------------------
    ; When input is valid, reset stack and return
    ; --------------------------------------------
    valid:
        mov		[ebx], eax      ; put user input into numsToGen
        pop     ebp             ; STACK: ret@, @numsToGen
        ret     4               ; pop off @numsToGen

getData ENDP

; NAME: fillArray
; description: Fill the array (numArr) with random numbers. Amount of elements 
;   numsToGenerate will equal.
; parameters (in stack order): @numArr, numsTroGenerate
; returns: numArr filled with the user's requested amount of random numbers
; preconditions: TODO numsToGenerate != NULL, count = 0, numArr is empty, LO < HI
; registers changed: ebp, edp, ecx, edi, eax
fillArray PROC      ; TODO

    ; STACK: @ret, @numArr, numsTroGenerate
    ; set up stack
    push    ebp                 ; STACK: ebp, @ret, @numArr, numsTroGenerate
    mov     ebp, esp
    mov     ecx, [ebp+12]        ; put numsToGenerate into ECX
    mov     edi, [ebp+8] 

    ; --------------------------------------------
    ; Generate random integers between HI and LO. 
    ; Fill numArr with user's requested amount of 
    ; random numbers. 
    ; --------------------------------------------
    genRandomIntLoop:
        mov     eax, HI         ; generate random number, from lecture 20
        sub     eax, LO
        inc     eax
        call    RandomRange
        add     eax, LO
        mov     [edi], eax      ; put random value into numArr
        add     edi, 4          ; increment to next index
        loop    genRandomIntLoop
       
        pop     ebp             ; STACK: @ret, @numArr, numsTroGenerate
        ret     8               ; pop off numsTroGenerate, @numArr

fillArray ENDP

; NAME: sortArray
; description: TODO
; parameters (in stack order): TODO
; returns: TODO
; preconditions: TODO
; registers changed: TODO
;
;for (k=0; k<request-1; k++) {
;   i = k;
;   for (j=k+1; j<request; j++) {
;      if (array[j] > array[i])
;         i = j;
;   }
;   exchange(array[k], array[i]);
;}
;
sortArray PROC      ; TODO

    push    ebp                 ; STACK: ebp, @ret, @numArr, numsTroGenerate
    mov     ebp, esp
    mov     ecx, [ebp+12]       ; put numsToGenerate into ECX
    dec     ecx                 ; adjust for index
    mov     edi, [ebp+8] 

    ; --------------------------------------------
    ; TODO: for (k=0; k<request-1; k++) i = k;
    ; --------------------------------------------
    outerLoop: 
        
        push    ecx             ; STACK: k (ecx), ebp, @ret, @numArr, numsTroGenerate
        mov     esi, [ebp+12]

        ; exchange(array[k], array[i]
    
    ; --------------------------------------------
    ; TODO: desc
    ; --------------------------------------------
    swapElements: 
        loop    outerLoop

    ; --------------------------------------------
    ; TODO: for (j=k+1; j<request; j++)
    ; --------------------------------------------
    innerLoop: 
        ; if (array[j] > array[i]) i = j;
        mov		eax, [esi]

    

sortArray ENDP

; NAME: displayMedian
; description: TODO
; parameters (in stack order): @medianPrompt, @numArr, numsTroGenerate
; returns: TODO
; preconditions: TODO
; registers changed: TODO
displayMedian PROC 

    ; set up stack frame
    push    ebp                 ; STACK: ebp, @ret, @medianPrompt, @numArr, numsTroGenerate
    mov     ebp, esp
    mov     eax, [ebp+16]        ; put numsToGenerate into EAX
    mov     esi, [ebp+12] 
    mov     edx, 0

    ; median = (n + 1) / 2
    mov     eax, 1
    div     2
    cmp     edx, 0
    je      oddMedian

    ; --------------------------------------------
    ; Find median for even array lengths
    ; --------------------------------------------
    evenMedian:
    ; get first number
    mul     4           ; multiply eax by 4 
    add     esi, eax
    mov     edx, [esi]  ; put 1st num in edx

    ; get second number
    add     esi, 4
    mov     eax, [esi]  ; put 2nd num in eax

    ; find average of two numbers
    add     eax, edx    ; add both numbers together
    mov     edx, 0      ; reset edx
    div     2           ; divide sum by 2

    jmp     printMedian

    ; --------------------------------------------
    ; Retrieve odd median (middle of array)
    ; --------------------------------------------
    oddMedian:
        mul     4           ; multiply eax by 4
        add     esi, eax
        mov     eax, [esi]

    ; --------------------------------------------
    ; Print the median (eax)
    ; --------------------------------------------
    printMedian:
        call    CrLf
        mov     edx, [ebp+8]
        call    WriteString
        call	WriteDec
        call    CrLf

    pop     ebp
    ret     12

displayMedian ENDP

; NAME: displayList
; description: TODO
; parameters (in stack order): @prompt, @numArr, numsTroGenerate
; returns: TODO
; preconditions: TODO
; registers changed: TODO
displayList PROC        ; TODO

    push    ebp     ; STACK: ebp, @ret, @prompt, @numArr, numsTroGenerate
    mov     ebp, esp
    mov     ecx, [ebp+16]        ; put numsToGenerate into ECX
    mov     esi, [ebp+12]        ; put numArr into esi

    ; display prompt
    call    CrLf
    mov     edx, [ebp+8]         ; put prompt into edx
    call    WriteString
    call    CrLf
    mov     edx, 0

    ; --------------------------------------------
    ; Loop through numArr and print each integer
    ; --------------------------------------------
    printInt:
        ; print int and spacing
        mov		eax, [esi+edx]
        call	WriteDec
        mov		edx, OFFSET spaces
        call	WriteString

        ; increment indexes
        add		edx, 4
        inc		lineIndex

        ; print new line if needed
        cmp		lineIndex, MAX_PER_LINE
        jg		newLine
        loop	printInt
        
        mov		lineIndex, 0            ; reset lineIndex
        jmp		stopPrint

    ; --------------------------------------------
    ; Make new line after reaching MAX_PER_LINE 
    ;   index
    ; --------------------------------------------
    newLine:
        call	CrLf
        mov		lineIndex, 0            ; reset lineIndex
        loop	printInt

    ; --------------------------------------------
    ; Stop printing process, clear register, and 
    ;   exit function
    ; --------------------------------------------
    stopPrint:
        pop     ebp         ; STACK: @ret, @prompt, @numArr, numsTroGenerate
        ret     12

displayList ENDP

; NAME: goodbye
; description: TODO
; parameters (in stack order): TODO
; returns: TODO
; preconditions: TODO
; registers changed: TODO
goodbye		PROC        ; TODO
	mov		edx, OFFSET byeMsg
	call	WriteString
	ret
goodbye		ENDP

END main