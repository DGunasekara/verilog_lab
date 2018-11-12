.text
.global main

main:
	SUB sp,sp,#4		@store link
	STR lr,[sp,#0]

	SUB sp,sp,#200		@allocating space forthe inputs

	MOV r5,#0		@to start a count --> i=0

	LDR r0,=formatp1	@prompting the caller to give number of strings	
	BL printf

	LDR r0,=formats1	@scan the number
	MOV r1,sp
	BL scanf

	LDR r4,[sp,#0]		@store r4 in stack

	CMP r4,#0		@compare r4 with zero
	BEQ exit		@if not go to exit
	BGT while		@if so go to the while block
	LDR r0,=formatp4	@if the caller enter an invalid value
	BL printf
	B exit1

while:

	CMP r5,r4		@comparing with i
	BGE exit1		@if greater or equal--> go to exit1

	LDR r0,=formatp2	@if so prompting the caller to enter the string
	MOV r1,r5
	BL printf

	@LDR r0,=formats2	@scan the string
	MOV r0,sp
	BL gets			@gave an warning and wrong answers when "gets" is used

	MOV r0,sp		@taking the string length of the entered string
	MOV r6,r0
	BL strlen

	MOV r7,r0		@assigning the string to r7

	MOV r1,r5		@assinging i to r1
	LDR r0,=formatp3	@print the sentence to tell caller that the output
	BL printf

	MOV r0,r6		@moving the length to do the reverse
	MOV r1,r7
	BL reverse

reverse:

	SUB sp,sp,#8		@allocating the stack for 2 items
	STR r4,[sp,#0]		@to use r4,store the the things on stack
	STR r5,[sp,#4]		@to use r5,store the the things on stack(i)

	MOV r4,r0		@assing the value in r0 to r4		
	MOV r5,r1		@assing the value to r1 r5

	SUB r5,r5,#1		@decrementing the number

getchar:

	CMP r5,#0		@to reverse,comparing with the zero
	BLT exitReverse		@otherwise exit from the getchar loop and return
	ADD r0,r4,r5

	LDRB r1,[r0,#0]		@loading bit wise
	LDR r0,=formatp5	@printing character wise
	BL printf

	SUB r5,r5,#1		@decrement the number by 1
	B getchar

exitReverse:

	LDR r0,=formatp6	@after all are done new line
	BL printf
	LDR r4,[sp,#0]		@restore the stack
	LDR r5,[sp,#4]
	ADD sp,sp,#8
	ADD r5,r5,#1
	B while			@for the new string

exit1:

	ADD sp,sp,#200		@restore the stack
	LDR lr,[sp,#0]
	ADD sp,sp,#4
	MOV sp,lr

	.data

formatp1: .asciz "Enter the number of strings :\n"
formats1: .asciz "%d"

formatp2: .asciz "Enter the input string %d :\n"
@formats2: .asciz "%s"

formatp3: .asciz "output string %d is :\n"

formatp4: .asciz "Invalid number\n"

formatp5: .asciz "%c"

formatp6: .asciz "\n"


