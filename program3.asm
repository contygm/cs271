TITLE Composite Number Spreadsheet     (program3.asm)

; Author: Genevieve Conty
; Last Modified: 07/29/2019
; OSU email address: contyg@oregonstate.edu
; Course number/section: CS271-400
; Assignment Number: Program #3                Due Date: 07/28/2019
; Description: Calculate composite numbers between 1 and 300 based on user input.

INCLUDE Irvine32.inc

; --------------------------------------------
; constant definitions for minimum and maximum
; --------------------------------------------
MAX	= 300
MIN	= 1

.data

; intro and exit prompts
welcomeMsg		BYTE	"Welcome to the Composite Number Spreadsheet",0
programTitle	BYTE	"Programmed by Genevieve Conty",0
extraCreditMsg	BYTE	"**EC: Program allows user to choose to display only odd composites.",0
description0	BYTE	"This program is capable of generating a list of composite numbers.",0
description1	BYTE	"Simply let me know how many you would like to see.",0
directions		BYTE	"I will accept orders for up to 300 composites.",0
inputPrompt		BYTE	"How many composites do you want to view? [1 .. 300]: ",0
thanksMsg		BYTE	"Thanks for using my program!",0

; validation error 
invalidMsg		BYTE	"Out of range. Please try again.",0

.code
main PROC

; --------------------------------------------
; Display instructions and greeting
; --------------------------------------------
introduction:
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

; TODO
; --------------------------------------------
; TODO
; --------------------------------------------
getData:
	mov		edx, OFFSET inputPrompt
	call	WriteString
	call	CrLf

; TODO
; --------------------------------------------
; TODO
; --------------------------------------------
validate:

; --------------------------------------------
; Display error message for failed validation
; --------------------------------------------
displayErrorMsg:
	mov		edx, OFFSET invalidMsg
	call	WriteString
	call	CrLf
;	jmp		getData

; TODO
; --------------------------------------------
; Display composites based on user-given range
; --------------------------------------------
showComposites:

; TODO
; --------------------------------------------
; Display only odd composite values
; --------------------------------------------
oddOnly:

; TODO
; --------------------------------------------
; Verify whether next number is composite
; --------------------------------------------
isComposite:

; --------------------------------------------
; Display closing message and exit program
; --------------------------------------------
goodbye:
	mov		edx, OFFSET thanksMsg
	call	WriteString

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main