TITLE Demonstrating lowlevel I/O procedures     (program5a.asm)

; Author: Genevieve Conty
; Last Modified: 08/12/2019
; OSU email address: contyg@oregonstate.edu
; Course number/section: CS271-400
; Assignment Number: Program #5a                Due Date: 08/12/2019
; Description: Get 10 valid integers from the user and store the numeric 
;	values into an array. Display the list of integers, their sum, and 
;	the average value of the list.

INCLUDE Irvine32.inc

; --------------------------------------------
; constant definitions
; --------------------------------------------
ARRAY_SIZE = 10

; --------------------------------------------
; macros definitions
; --------------------------------------------

; NAME: getString
; description: Display a prompt, get user input, put user input into memory.
; parameters (in stack order): @strAddress, @prompt
; returns: TODO
; preconditions: TODO
; registers changed: TODO
; CITATION: Lecture 26 - Macros
; TODO getString

getString MACRO address, prompt
	push	edx
	push	ecx
	mov		edx, prompt
	call	WriteString
	mov		edx, address
	mov		ecx, 254
	call	ReadString
	pop		ecx
	pop		edx
	
ENDM

; NAME: displayString
; description: Print string
; parameters (in stack order): @strAddress 
; returns: displays passed string
; preconditions: none
; registers changed: edx
; CITATION: Lecture 26 - Macros

displayString MACRO strAddress

	push	edx
	mov		edx, strAddress		; macro accepts OFFSET so don't need to use OFFSET here
	call	WriteString
	pop		edx

ENDM

.data

; prompt
programTitle	BYTE	"Demonstrating low-level I/O procedures",0	;39b
author			BYTE	"Written by Genevieve Conty",0				; 27b
directions_0	BYTE	"Please provide 10 decimal integers.",0		; 36b
directions_1	BYTE	"Each number needs to be small enough to fit inside a 32 bit register.",0	;69b
directions_2	BYTE	"After you have finished inputting the raw numbers I will display a list of the integers, their sum, and their average value.",0	;124 char
inputPrompt		BYTE	"Please enter an integer number: ",0	;33b
invalidMsg		BYTE	"ERROR: You did not enter an integer number or your number was too big.",0	;71
reInputPrompt	BYTE	"Please try again: ",0	;19	b
showInputsMsg	BYTE	"You entered the following numbers:",0	;35b
sumMsg			BYTE	"The sum of these numbers is: ",0	;30b
avgMsg			BYTE	"The average is: ",0	;17b
thanksMsg		BYTE	"Thanks for playing!",0	;20b
commaSpace		BYTE	",  ",0	;4b
tempNum			DWORD	?

; variables
numArray		DWORD	ARRAY_SIZE DUP(?)
inputStr		BYTE	32 DUP(0)
buffer			BYTE	255 DUP(0)

.code
main PROC

	;intro
	push	OFFSET directions_2
	push	OFFSET directions_1
	push	OFFSET directions_0
	push	OFFSET author
	push	OFFSET programTitle
	call	introduction		; stack: @ret, @title, @author, @d0, @d1, @d2

	mov		ecx, ARRAY_SIZE		; set up loop count
	mov     esi, OFFSET numArray		; put array in edi

	; --------------------------------------------
    ; Populate numArray with user input
    ; --------------------------------------------
	populate:	
		;push	OFFSET reInputPrompt
		;push	OFFSET invalidMsg
		;push	OFFSET inputPrompt
		;push	OFFSET buffer
		call	ReadVal
		mov		eax, tempNum
		mov     [esi], eax			; converted string into array
        add     esi, 4          ; increment to next index
        loop    populate

	;TODO printArray
	;TODO calcSum
	;TODO calcAvg

	;goodebye
	push	OFFSET thanksMsg	; stack: @ret, @thanksMsg
	call	goodbye

	exit	; exit to operating system
main ENDP

; NAME: introduction
; description: Display program greetings and instructions to the user
; parameters (in stack order): @title, @author, @description_0, @description_1, @description_2
; returns: n/a
; preconditions: passed prompts are not null
; registers changed: ebp, esp, edx
introduction	PROC
	; set up stack frame
	push    ebp                 
    mov     ebp, esp

	mov		edx, [ebp+8]	; can't pass address directly into macro call
	displayString edx		; title
	call	CrLf
	
	mov		edx, [ebp+12]
	displayString edx		; author
	call	CrLf

	displayString [ebp+16]	; d0
	call	CrLf

	displayString [ebp+20]	; d1
	call	CrLf

	displayString [ebp+24]	; d2
	call	CrLf
	
	pop		ebp
	ret		20

introduction	ENDP

; NAME: goodbye
; description: Display program end greeting
; parameters (in stack order): @thanksMsg
; returns: displays thanks message
; preconditions: thanks message isn't null
; registers changed: ebp, esp, edx
goodbye			PROC
	push    ebp
	mov     ebp, esp
	mov		edx, [ebp+8]
	displayString edx

	pop		ebp
	ret		4

goodbye			ENDP

; NAME: ReadVal
; description: Using getString macro, get the user’s input as string. Convert 
;	the string to integers. Validatie the user’s input.
; parameters (in stack order): @buffer, @inputPrompt, @invalidMsg, @reInputPrompt
; returns: TODO
; preconditions: TODO
; registers changed: TODO

; TODO ReadVal
ReadVal		PROC
	LOCAL number:DWORD
							; push general purpose registers onto stack
	push    ebp
	mov     ebp, esp
pushad
	mov		edx, OFFSET inputPrompt		; inputPrompt
	
	; --------------------------------------------
    ; Get user input as string. Validate that chars
	; are valid ascii nums
    ; --------------------------------------------
	readInput:
		mov		ebx, OFFSET buffer		; buffer
		getString ebx, edx
		mov		esi, ebx		; set up registers	
		mov		eax, 0											
		mov		ecx, 0											
		mov		ebx, 10			; need to multiply by 10 for proper placement
	loadString:
		lodsb
		cmp		al, 0			; check if end of string
		je		finish
		cmp		al, 57			; upperlimit, 9
		jg		invalid
		cmp		al, 48			; lowerlimit, 0
		jl		invalid

		; convert from char to int
		sub		al, 48
		xchg	eax, ecx
		mul		ebx
		jc		invalid			; if carry flag is set, number is out of range
		add		eax, ecx
		xchg	eax, ecx
		jmp		loadString

	; --------------------------------------------
    ; For invalid inputs, reprompt user
    ; --------------------------------------------
	invalid:
		mov edx, OFFSET invalidMsg
		displayString edx	; display error
		call	CrLf
		mov		edx, OFFSET reInputPrompt	; reprompt 
		jmp		readInput

	finish: 
		xchg	ecx, eax
		mov		tempNum, eax
		popad
		pop	ebp
		ret

ReadVal		ENDP

; NAME: WriteString
; description: Convert a integer to a string. Using the displayString macro, 
;	output the string conversion.
; parameters (in stack order): TODO
; returns: TODO
; preconditions: TODO
; registers changed: TODO

; TODO WriteVal
WriteVal		PROC

WriteVal		ENDP

; NAME: calculateAvg
; description: Caluclate the average of the number array 
; parameters (in stack order): TODO
; returns: TODO
; preconditions: TODO
; registers changed: TODO
calculateAvg	PROC

calculateAvg	ENDP

; NAME: calculateSum
; description: Caluclate the sum of the number array 
; parameters (in stack order): TODO
; returns: TODO
; preconditions: TODO
; registers changed: TODO
calculateSum	PROC

calculateSum	ENDP

END main
