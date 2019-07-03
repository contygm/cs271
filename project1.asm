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

; EC Data
intro_EC_1 	BYTE	"**EC: Program verifies second number less than first.",0
intro_EC_2 	BYTE	"**EC: Program displays square of inputted numbers.",0
notValid	BYTE	"The value is not less than the first number",0
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

; TODO Prompt the user to enter two numbers
	mov		edx, OFFSET prompt_1
	call	WriteString
	call	CrLf

	mov		edx, OFFSET prompt_2
	call	WriteString
	call	CrLf

; TODO Calculate the sum, difference, product, (integer) quotient and remainder 
	mov		edx, OFFSET plus
	mov		edx, OFFSET equals
	call	WriteString
	call	CrLf

	mov		edx, OFFSET minus
	mov		edx, OFFSET equals
	call	WriteString
	call	CrLf

	mov		edx, OFFSET multiply
	mov		edx, OFFSET equals
	call	WriteString
	call	CrLf

	mov		edx, OFFSET divide
	mov		edx, OFFSET equals
	mov		edx, OFFSET remainder
	call	WriteString
	call	CrLf

; --------------- EXTRA CREDIT -----------------------
; TODO Display the square of each number
	mov		edx, OFFSET square
	call	WriteString
	call	CrLf

	mov		edx, OFFSET square
	call	WriteString
	call	CrLf

; TODO Validate the second number to be less than the first
	mov		edx, OFFSET notValid
	call	WriteString
	call	CrLf
; --------------- END EC -----------------------

; Display a terminating message
	mov		edx, OFFSET outro

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
