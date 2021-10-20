.main:
	mov r0, 6
	mov r1, 1
	mov r2, 1
	.loop:
		cmp r0, 0
		beq .break
		mul r1, r0, r1
		sub r0, r0, 1
		b .loop  
	.break:
		.print r1