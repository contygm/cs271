TITLE Composite Number Spreadsheet     (program3.asm)

; Author: Genevieve Conty
; Last Modified: 07/29/2019
; OSU email address: contyg@oregonstate.edu
; Course number/section: CS271-400
; Assignment Number: Program #3                Due Date: 07/28/2019
; Description: Calculate composite numbers between 1 and 300 based on user input.

INCLUDE Irvine32.inc

; --------------------------------------------
; constant definitions
; --------------------------------------------
MAX	= 300
MIN	= 1
MAX_PER_LINE = 9

.data

; prompts
welcomeMsg		BYTE	"Welcome to the Composite Number Spreadsheet",0
programTitle	BYTE	"Programmed by Genevieve Conty",0
description0	BYTE	"This program is capable of generating a list of composite numbers.",0
description1	BYTE	"Simply let me know how many you would like to see.",0
directions		BYTE	"I will accept orders for up to 300 composites.",0
inputPrompt		BYTE	"How many composites do you want to view? [1 .. 300]: ",0
thanksMsg		BYTE	"Thanks for using my program!",0
invalidMsg		BYTE	"Out of range. Please try again.",0
spaces			BYTE	"   ",0

; variables
range			DWORD	?
lineIndex		DWORD	0
currentNum		DWORD	1
isComp			DWORD	0

.code

main PROC
	call introduction
	call getData
	call showComposites
	call goodbye
	exit	; exit to operating system
main ENDP

; --------------------------------------------
; Display instructions and greeting
; --------------------------------------------
introduction PROC
	mov		edx, OFFSET welcomeMsg
	call	WriteString
	call	CrLf

	mov		edx, OFFSET programTitle
	call	WriteString
	call	CrLf

	mov		edx, OFFSET description0
	call	WriteString
	call	CrLf

	mov		edx, OFFSET description1
	call	WriteString
	call	CrLf

	mov		edx, OFFSET directions
	call	WriteString
	call	CrLf
	
	ret
introduction ENDP

; --------------------------------------------
; Prompt user for range of composite numbers
; and store that number in a variable
; --------------------------------------------
getData		PROC
	mov		edx, OFFSET inputPrompt
	call	WriteString
	call	ReadInt
	mov		range, eax
	call	validate		; validate that range is between min/max
	ret
getData		ENDP

; --------------------------------------------
; Validate user input against min/max
; --------------------------------------------
validate	PROC
	cmp		range, MAX		; if input > max
	jg		displayErrorMsg		
	cmp		range, MIN		; if input < min
	jl		displayErrorMsg
	jmp		valid

	; --------------------------------------------
	; Display error message for failed validation
	; --------------------------------------------
	displayErrorMsg:
		mov		edx, OFFSET invalidMsg
		call	WriteString
		call	CrLf
		jmp		getData

	valid:
		ret

validate	ENDP

; --------------------------------------------
; Display composites based on user-given range
; --------------------------------------------
showComposites	PROC
	mov		ecx, range			; initialize loop counter

	displayNums:
		call	isComposite	
		; print composite number
		mov		eax, currentNum	
		call	WriteDec
		mov		edx, OFFSET spaces
		call	WriteString
		inc		currentNum
		inc		lineIndex		
		cmp		lineIndex, MAX_PER_LINE		; check that only 10 numbers per line
		jg		newLine						; new line if needed
		loop	displayNums
		jmp		stop

	newLine:
		call	CrLf
		mov		lineIndex, 0
		loop	displayNums

	stop:
		call	CrLf
		ret

showComposites	ENDP

; --------------------------------------------
; Verify whether next number is composite, keeps
; incrementing number until next composite is 
; reached
; --------------------------------------------
isComposite		PROC

	mov		eax, currentNum
	
	; check number isn't prime and can be divided by
	; 2, 3, 5, 7
	divLoop: 
		; check that number isn't base prime numbers 
		cmp		eax, 2
		je		notComp
		cmp		eax, 3
		je		notComp
		cmp		eax, 5
		je		notComp
		cmp		eax, 7
		je		notComp

		; check if numbers are divisible by base prime numbers
		mov		edx, 0		
		mov		ebx, 2
		div		ebx
		cmp		edx, 0	; if no remainder, it's composite
		je		stop

		mov		eax, currentNum
		mov		edx, 0		
		mov		ebx, 3
		div		ebx
		cmp		edx, 0
		je		stop

		mov		eax, currentNum
		mov		edx, 0		
		mov		ebx, 5
		div		ebx
		cmp		edx, 0
		je		stop

		mov		eax, currentNum
		mov		edx, 0		
		mov		ebx, 7
		div		ebx
		cmp		edx, 0
		je		stop
		jmp		notComp	

	; increment to next number
	notComp:
		inc		currentNum
		mov		eax, currentNum
		mov		edx, 0
		jmp		divLoop

	stop:
		ret
isComposite		ENDP

; --------------------------------------------
; Display closing message and exit program
; --------------------------------------------
goodbye		PROC
	mov		edx, OFFSET thanksMsg
	call	WriteString
	call	CrLf
	ret
goodbye		ENDP

END main