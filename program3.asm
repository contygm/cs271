TITLE Composite Number Spreadsheet     (program3.asm)

; Author: Genevieve Conty
; Last Modified: 07/29/2019
; OSU email address: contyg@oregonstate.edu
; Course number/section: CS271-400
; Assignment Number: Program #3                Due Date: 07/28/2019
; Description: Calculate composite numbers between 1 and 300 based on user input.

INCLUDE Irvine32.inc

; constant definitions for minimum and maximum
MAX		DWORD		300
MIN		DWORD		1

.data

; intro and exit prompts
welcomeMsg		"Welcome to the Composite Number Spreadsheet",0
programTitle	"Programmed by Genevieve Conty",0
extraCreditMsg	"**EC: Program allows user to choose to display only odd composites.",0
description0	"This program is capable of generating a list of composite numbers.",0
description1	"Simply let me know how many you would like to see.",0
directions		"I’ll accept orders for up to 300 composites.",0
inputPrompt		"How many composites do you want to view? [1 .. 300]: ",0
thanksMsg		"Thanks for using my program!",0

; validation error 
invalidMsg		"Out of range. Please try again.",0


.code
main PROC

; TODO
; --------------------------------------------
; TODO
; --------------------------------------------
introduction:

; TODO
; --------------------------------------------
; TODO
; --------------------------------------------
getData:

; TODO
; --------------------------------------------
; TODO
; --------------------------------------------
validate:

; TODO
; --------------------------------------------
; TODO
; --------------------------------------------
showComposites:

; TODO
; --------------------------------------------
; TODO
; --------------------------------------------
isComposite:

; TODO
; --------------------------------------------
; TODO
; --------------------------------------------
goodbye:

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
