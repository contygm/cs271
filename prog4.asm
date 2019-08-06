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
byeMsg			BYTE    "Thanks for using my program!",0

; variables
range           DWORD   ?               ; randomly generated range
numArr          DWORD   MAX DUP(?)      ; array for random numbers, as big as MAX
numsToGenerate  DWORD   ?               ; user input, how many numbers to be generated
spaces          BYTE    "     ",0       ; 5 spaces
lineIndex		DWORD	0

endLoopMsg		BYTE	"end of genRandomInts",0

.code
main PROC
    
    call	RANDOMIZE                   ; need to call at the begining of the prog
    call    introduction
 
    ; push ref to numsToGenerate onto stack (esp)
    push    OFFSET numsToGenerate       
    call    getData

	mov		edx, OFFSET endLoopMsg
    call	WriteString
	call	CrLf

	exit	; exit to operating system
main ENDP

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

getData PROC

    ; set up stack
    push    ebp             
    mov     ebp, esp
    mov     ebx, [ebp+8]        ; put @numsToGenerate ref into EBX 
    ; STACK: ebp, ret@, @numsToGen

inputLoop:
    mov		edx, OFFSET inputPrompt
    call	WriteString
    call	ReadInt

    ; validate that user input is between MIN/MAX
    cmp		eax, MAX		    ; if input > MAX
    jg		displayErrorMsg		
    cmp		eax, MIN		    ; if input < MIN
    jl		displayErrorMsg
    jmp		valid

displayErrorMsg:
    mov		edx, OFFSET invalidMsg
    call	WriteString
    call	CrLf
    jmp		inputLoop       ; loop back to top of inputLoop

valid:
	call	WriteDec
    mov		[ebx], eax      ; put user input into numsToGen
	call	WriteDec
    pop     ebp             ; STACK: ret@, @numsToGen
	call	WriteDec
    ret     4               ; pop off @numsToGen

getData ENDP

END main
