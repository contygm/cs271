TITLE  Fibonacci Numbers  (program2.asm)

; Author: Genevieve Conty
; Last Modified: 07/14/2019
; OSU email address: contyg@oregonstate.edu
; Course number/section: CS271-400
; Assignment Number: Program #2                Due Date: 07/14/2019
; Description: Calculates Fibonacci sequence based on range given by user

INCLUDE Irvine32.inc

; (insert constant definitions here)

.data

; prompts and error messages
programTitle	BYTE	"Fibonacci Numbers",0
author			BYTE	"Programmed by Genevieve Conty",0
namePrompt		BYTE	"What is your name? ",0
greeting		BYTE	"Hi, ",0
instructions_0	BYTE	"Enter the number of Fibonacci terms to be displayed.",0
instructions_1	BYTE	"Provide the number as an integer in the range [1 .. 46].",0
termsPrompt		BYTE	"How many Fibonacci terms do you want? ",0
outOfRange		BYTE	"Out of range. Enter a number in [1 .. 46]",0
partingPrompt	BYTE	"Results certified by GConty.",0
goodbye			BYTE	"Goodbye, ",0


; constants and inputs
userName		BYTE	20 DUP(0)
max				DWORD	46
min				DWORD	1
term_1			DWORD	1	
term_2			DWORD	1
totalTerms		DWORD	?
fiveSpaces		BYTE	"     ",0
termsPerLine	BYTE	2			; account for initial terms in line

.code
main PROC

; ---------------------------------------------
; Display program title and author
; ---------------------------------------------
introduction:
	mov		edx, OFFSET programTitle
	call	WriteString
	call	CrLf

	mov		edx, OFFSET author
	call	WriteString
	call	CrLf

; ---------------------------------------------
; Get user name and display greeting
; ---------------------------------------------
getUserInfo:
	; get and store username
	mov		edx, OFFSET namePrompt
	call	WriteString
	mov		edx, OFFSET userName
	mov		ecx, 20
	call	ReadString

	; personalized gretting
	mov		edx, OFFSET	greeting
	call	WriteString
	mov		edx, OFFSET	userName
	call	WriteString
	call	CrLf

; ---------------------------------------------
; Display program instructions
; ---------------------------------------------
displayInstructions:
	mov		edx, OFFSET instructions_0
	call	WriteString
	call	CrLf

	mov		edx, OFFSET instructions_1
	call	WriteString
	call	CrLf

; ---------------------------------------------
; Display the Fibonacci terms 
; ---------------------------------------------
displayFibs:
	mov		edx, OFFSET termsPrompt
	call	WriteString
	call	ReadInt
	mov		totalTerms, eax

	; validate totalTerms with post-test setup
	cmp		eax, max		; if totalTerms > max
	jg		rangeError		
	cmp		eax, min		; if totalTerms < min
	jl		rangeError
	je		single			; if only 1 term
	cmp		eax, 2
	je		double			; if only 2 terms

	; print first two terms of fib
	mov		eax, term_1
	call	WriteDec
	mov		edx, OFFSET fiveSpaces
	call	WriteString
	mov		eax, term_2
	call	WriteDec
	mov		edx, OFFSET fiveSpaces
	call	WriteString

	; initialize loop variables
	mov		eax, term_1
	mov		ebx, term_2
	mov		ecx, totalTerms
	sub		ecx, 2				; accounts for two terms already handled

; incremented loop for fib sequence
fibLoop:
	inc		termsPerLine
	add		eax, ebx		; add first and second terms
	call	WriteDec
	mov		edx, OFFSET	fiveSpaces
	call	WriteString
	
	xchg	eax, ebx			; swap so summed value(eax) becomes second term
	cmp		termsPerLine, 4		; check that line has <=4 terms
	je		nextLine

	loop	fibLoop
	call	CrLf
	jmp		farewell

; make new line for fib printing
nextLine:
	call	CrLf
	mov		termsPerLine, 0		; reset to term count to 0 for new line
	loop	fibLoop
	jmp		farewell

; ---------------------------------------------
; Display range error
; --------------------------------------------
rangeError:
	mov		edx, OFFSET outOfRange
	call	WriteString
	call	CrLf
	jmp		displayFibs

; ---------------------------------------------
; print one term fib sequence
; --------------------------------------------
single:
	mov		eax, term_1
	call	WriteDec
	call	CrLf
	jmp		farewell

; ---------------------------------------------
; print two term fib sequence
; --------------------------------------------
double:
	mov		eax, term_1
	call	WriteDec
	mov		edx, OFFSET fiveSpaces
	call	WriteString
	mov		eax, term_2
	call	WriteDec
	call	CrLf

; ---------------------------------------------
; Give goodbye message to user and exit
;	program
; ---------------------------------------------
farewell:
	mov		edx, OFFSET partingPrompt
	call	WriteString
	call	CrLf
	mov		edx, OFFSET	goodbye
	call	WriteString
	mov		edx, OFFSET	userName
	call	WriteString
	call	CrLf

	exit	; exit to operating system
main ENDP

END main
