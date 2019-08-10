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
; parameters (in stack order): TODO
; returns: TODO
; preconditions: TODO
; registers changed: TODO
; CITATION: Lecture 26 - Macros
; TODO getString -> ReadString

getString MACRO 


; NAME: displayString
; description: Print string
; parameters (in stack order): TODO
; returns: TODO
; preconditions: TODO
; registers changed: TODO
; TODO displayString --> use WriteString

.data

; prompt
programTitle	BYTE	"Demonstrating low-level I/O procedures",0
author			BYTE	"Written by Genevieve Conty",0
directions_0	BYTE	"Please provide 10 decimal integers.",0
directions_1	BYTE	"Each number needs to be small enough to fit inside a 32 bit register.",0
directions_2	BYTE	"After you have finished inputting the raw numbers I will display a list of the integers, their sum, and their average value.",0
inputPrompt		BYTE	"Please enter an integer number: ",0
invalidMsg		BYTE	"ERROR: You did not enter an integer number or your number was too big.",0
reInputPrompt	BYTE	"Please try again: ",
showInputsMsg	BYTE	"You entered the following numbers:",0
sumMsg			BYTE	"The sum of these numbers is: ",0
avgMsg			BYTE	"The average is: ",0
thanksMsg		BYTE	"Thanks for playing!",0
commaSpace		BYTE	",  ",0


; variables
numArray		DWORD	ARRAY_SIZE DUP(?)

.code
main PROC

	;TODO intro
	;TODO getData
	;TODO printArray
	;TODO calcSum
	;TODO calcAvg
	;TODO goodebye

	exit	; exit to operating system
main ENDP

; NAME: introduction
; description: Display program greetings and instructions to the user
; parameters (in stack order): TODO
; returns: TODO
; preconditions: TODO
; registers changed: TODO
introduction	PROC

introduction	ENDP

; NAME: goodbye
; description: Display program end greeting
; parameters (in stack order): TODO
; returns: TODO
; preconditions: TODO
; registers changed: TODO
goodbye			PROC

goodbye			ENDP

; NAME: getNumInputs
; description: Get inputs from user and put them into numArray. 
; parameters (in stack order): TODO
; returns: TODO
; preconditions: TODO
; registers changed: TODO
getNumInputs	PROC

getNumInputs	ENDP

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

; NAME: ReadVal
; description: Using getString macr, get the user’s input as string. Convert 
;	the string to integers. Validatie the user’s input.
; parameters (in stack order): TODO
; returns: TODO
; preconditions: TODO
; registers changed: TODO

; TODO ReadVal
ReadVal		PROC

ReadVal		ENDP

; NAME: WriteString
; description: Convert a integer to a string. Using the displayString macro, 
;	output the string conversion.
; parameters (in stack order): TODO
; returns: TODO
; preconditions: TODO
; registers changed: TODO

; TODO WriteString
WriteString		PROC

WriteString		ENDP

END main