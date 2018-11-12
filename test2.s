@ ARM Assembly lab 4

	.text	@ instruction memory
	
	.global main
main:
	@ stack handling, 
        @ push (store) lr to the stack

	sub	sp, sp, #4
	str	lr, [sp, #0]		@store the link 

	@allocate stack for input/scanf
	@sub	sp, sp, #4


	@printf for number of strings
	ldr	r0, =formatr1
	bl	printf

	@scanf for number of strings
	ldr	r0, =formats1
	mov	r1, sp	
	bl	scanf	@scanf("%d",sp)

	@copy number from stack to register r4

	ldr	r4, [sp]

	@ther should have a for loop until the 

	@counter
	mov	r5, #0

loop:	@push (store) lr to the stack, allocate space for 100 chars (scanf)	
	sub	sp, sp, #200
@	str	lr, [sp, #200]
	@printf for asking the string 

	cmp	r5, r4
	bge	exit	
		
	ldr	r0, =formatr2
	mov	r1, r5
	bl	printf
	
	@scanf for string 

	ldr	r0, =formats2
	mov	r1, sp
	bl	scanf	@scanf("%s",sp)

	@function call for the length of the string 

	mov	r0, sp
	bl	stringLen

	@output string
	ldr	r0, =formatr3
	mov	r1, r5
	bl	printf


	@print answer
	mov	r1, sp
	mov	r2, r0
	ldr	r0, =formatp
	bl	printf
	
    @ stack handling (pop lr from the stack) and return
	mov	r0, #0		@return 0
	ldr	lr, [sp, #200]
	add	sp, sp, #204
	mov	pc, lr		


	@ string length function
stringLen:
	sub	sp, sp, #4
	str	lr, [sp, #0]

	mov	r1, #0	@ length counter

loop2:
	ldrb	r2, [r0, #0]
	cmp	r2, #0
	beq	endLoop

	add	r1, r1, #1	@ count length
	add	r0, r0, #1	@ move to the next element in the char array
	b	loop2

endLoop:
	mov	r0, r1		@ to return the length
	ldr	lr, [sp, #0]
	add	sp, sp, #4
	mov	pc, lr




	
	.data	@ data memory

formatr1: .asciz "Enter the number of strings :\n"
formats1: .asciz "%d"
formatr2: .asciz "Enter the input string %d :\n"
formats2: .asciz "%s"
formatr3: .asciz "output string %d is :\n"
formatp: .asciz "The length of is %d\n"
