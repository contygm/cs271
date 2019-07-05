TITLE Program #1: Elementary Arithmetic      (project1.asm)

; Author: Genevieve Conty
; Last Modified: 07/07/2019
; OSU email address: contyg@oregonstate.edu
; Course number/section: CS271-400
; Assignment Number: Program #1       Due Date: 07/07/2019
; Description: Introduce myself and calculate the sum, difference, product, (integer) quotient and remainder of the numbers.

INCLUDE Irvine32.inc

.data

; prompts
intro_1		BYTE	"Elementary Arithmetic by Genevieve Conty",0
intro_2		BYTE	"Enter 2 numbers, and I'll show you the sum, difference, product, quotient, and remainder.",0
outro		BYTE	"Impressed? Bye",0
prompt_1	BYTE	"First number: ",0
prompt_2	BYTE	"Second number: ",0

; math signs
minus		BYTE	" - ",0
plus		BYTE	" + ",0
equals		BYTE	" = ",0
divide		BYTE	" / ",0
multiply	BYTE	" x ",0
remain		BYTE	" remainder ",0

; math results
sum			DWORD	?
difference	DWORD	?
product		DWORD	?
quotient	DWORD	?
remainder	DWORD	?
firstNum	DWORD	?
secondNum	DWORD	?

; EC Data
intro_EC_1 	BYTE	"**EC: Program verifies second number is less than first.",0
intro_EC_2 	BYTE	"**EC: Program squares both numbers.",0
notValid	BYTE	"The second number must be less than the first!",0
square		BYTE	"Square of ",0
squared		DWORD	?

.code
main PROC

; Display your name, program title, and EC notices
	mov		edx, OFFSET intro_1
	call	WriteString
	call	CrLf
	
	mov		edx, OFFSET intro_EC_1
	call	WriteString
	call	CrLf
	
	mov		edx, OFFSET intro_EC_2
	call	WriteString
	call	CrLf

; Display instructions for the user
	mov		edx, OFFSET intro_2
	call	WriteString
	call	CrLf

; Prompt the user to enter two numbers
	mov		edx, OFFSET prompt_1
	call	WriteString
	call	ReadInt
	mov		firstNum, eax

	mov		edx, OFFSET prompt_2
	call	WriteString
	call	ReadInt
	mov		secondNum, eax

; --------------- EXTRA CREDIT 1 -----------------------
; Validate the second number to be less than the first
	mov		eax, firstNum
	cmp		eax, secondNum
	jle		valError
	
; --------------- END EC 1 -----------------------

; Calculate and print sum
	mov		eax, firstNum
	add		eax, secondNum
	mov		sum, eax

; NOTE: WriteInt will also print the sign
	mov		eax, firstNum
	call	WriteDec
	mov		edx, OFFSET plus
	call	WriteString
	mov		eax, secondNum
	call	WriteDec
	mov		edx, OFFSET equals
	call	WriteString
	mov		eax, sum
	call	WriteDec
	call	CrLf

; calculate and print difference
	mov		eax, firstNum
	sub		eax, secondNum
	mov		difference, eax	

	mov		eax, firstNum
	call	WriteDec
	mov		edx, OFFSET minus
	call	WriteString
	mov		eax, secondNum
	call	WriteDec
	mov		edx, OFFSET equals
	call	WriteString
	mov		eax, difference
	call	WriteDec
	call	CrLf

; calculate and print product
	mov		eax, firstNum
	mul		secondNum
	mov		product, eax

	mov		eax, firstNum
	call	WriteDec
	mov		edx, OFFSET multiply
	call	WriteString
	mov		eax, secondNum
	call	WriteDec
	mov		edx, OFFSET equals
	call	WriteString
	mov		eax, product
	call	WriteDec
	call	CrLf

; calculate and print (integer) quotient and remainder
	mov		eax, firstNum
	mov		ebx, secondNum
	mov		edx, 0			; initialize remainder container
	div		ebx
	mov		quotient, eax
	mov		remainder, edx

	mov		eax, firstNum
	call	WriteDec
	mov		edx, OFFSET divide
	call	WriteString
	mov		eax, secondNum
	call	WriteDec
	mov		edx, OFFSET equals
	call	WriteString
	mov		eax, quotient
	call	WriteDec
	mov		edx, OFFSET remain
	call	WriteString
	mov		eax, remainder
	call	WriteDec
	call	CrLf

; --------------- EXTRA CREDIT 2 -----------------------
; Display the square of each number
	mov		eax, firstNum
	mul		firstNum
	mov		squared, eax

	mov		edx, OFFSET square
	call	WriteString
	mov		eax, firstNum
	call	WriteDec
	mov		edx, OFFSET equals
	call	WriteString
	mov		eax, squared
	call	WriteDec
	call	CrLf

	mov		eax, secondNum
	mul		secondNum
	mov		squared, eax

	mov		edx, OFFSET square
	call	WriteString
	mov		eax, secondNum
	call	WriteDec
	mov		edx, OFFSET equals
	call	WriteString	
	mov		eax, squared
	call	WriteDec
	call	CrLf
; --------------- END EC 2 -----------------------
valError:
	mov		edx, OFFSET notValid
	call	WriteString
	call	CrLf

terminate:
; Display a terminating message
	mov		edx, OFFSET outro
	call	WriteString
	call	CrLf

	exit	; exit to operating system
main ENDP

END main
