.main:
	mov r1,15
	mov r2,2
	mov r0,1
.loop:
	mod r3,r1,r2
	cmp r3,0
	beq .notprime
	add r2,r2,1
	mul r4,r2,r2
	cmp r4,r1
	bgt .exit
	b .loop

b .exit
.notprime:
	mov r0,0
.exit:
	.print r0
	

