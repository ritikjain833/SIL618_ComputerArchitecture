.quicksort:
    cmp r4,r2
    bgt .continue
    b .end
    .continue:
        
        sub sp,sp,4
        st ra,[sp]
        call .partition
        ld ra,[sp]
        add sp,sp,4

        sub sp,sp,16
        st r2,[sp]
        st r3,4[sp]
        st r4,8[sp]
        st ra,12[sp]
       
        add r2,r3,4
        call .quicksort
        ld r2,[sp]
        ld r3,4[sp]
        ld r4,8[sp]
        ld ra,12[sp]
        add sp,sp,16
        sub sp,sp,16
        st r2,[sp]
        st r3,4[sp]
        st r4,8[sp]
        st ra,12[sp]
        sub r4,r3,4
        call .quicksort
        ld r2,[sp]
        ld r3,4[sp]
        ld r4,8[sp]
        ld ra,12[sp]
        add sp,sp,16
    .end:
        ret
.partition:
    ld r10,[r4]
    sub r5,r2,4
    mov r6,r2
    .loop:
        cmp r6,r4
        beq .end1
        ld r7,[r6]
        cmp r10,r7 
        bgt .swap
        beq .swap
        b .increment
        .swap:
            add r5,r5,4
            ld r8,[r5]
            ld r9,[r6]
            add r8,r8,r9
            sub r9,r8,r9
            sub r8,r8,r9
            st r8,[r5]
            st r9,[r6]
        .increment:
            add r6,r6,4
            b .loop
    .end1:
        ld r8,[r4]
        ld r9,4[r5]    
        add r8,r8,r9
        sub r9,r8,r9
        sub r8,r8,r9
        st r8,[r4]
        st r9,4[r5]
        add r3,r5,4
        ret        




.main:
	@ Loading the values as an array into the registers
	mov r0, 0
	mov r1, -114
	st r1, 0[r0]
	mov r1, -115
	st r1, 4[r0]
	mov r1, -116
	st r1, 8[r0]
	mov r1, -117
	st r1, 12[r0]
	mov r1, -118
	st r1, 16[r0]
	mov r1, -119
	st r1, 20[r0]
	mov r1, -120
	st r1, 24[r0]
	mov r1, -121
	st r1, 28[r0]
	mov r1, -122
	st r1, 32[r0]
	mov r1, -123
	st r1, 36[r0]
	mov r1, -124
	st r1, 40[r0]
	mov r1, -125
	st r1, 44[r0]
	mov r1, -126
	st r1, 48[r0]
	mov r1, -127
	st r1, 52[r0]
	mov r1, -128
	st r1, 56[r0]
	mov r1, -129
	st r1, 60[r0]
	mov r1, -130
	st r1, 64[r0]
	mov r1, -131
	st r1, 68[r0]
	mov r1, -132
	st r1, 72[r0]
	mov r1, -133
	st r1, 76[r0]

	mov r2, 0 @ Starting address of the array

	@ Retreive the end address of the array
	mov r3, 19
	mul r3, r3, 4
	add r4, r2, r3

	
	
 	@ ADD YOUR CODE HERE 

	call .quicksort

 	@ ADD YOUR CODE HERE


	@ Print statements for the result
	ld r1, 0[r0]
	.print r1
	ld r1, 4[r0]
	.print r1
	ld r1, 8[r0]
	.print r1
	ld r1, 12[r0]
	.print r1
	ld r1, 16[r0]
	.print r1
	ld r1, 20[r0]
	.print r1
	ld r1, 24[r0]
	.print r1
	ld r1, 28[r0]
	.print r1
	ld r1, 32[r0]
	.print r1
	ld r1, 36[r0]
	.print r1
	ld r1, 40[r0]
	.print r1
	ld r1, 44[r0]
	.print r1
	ld r1, 48[r0]
	.print r1
	ld r1, 52[r0]
	.print r1
	ld r1, 56[r0]
	.print r1
	ld r1, 60[r0]
	.print r1
	ld r1, 64[r0]
	.print r1
	ld r1, 68[r0]
	.print r1
	ld r1, 72[r0]
	.print r1
	ld r1, 76[r0]
	.print r1