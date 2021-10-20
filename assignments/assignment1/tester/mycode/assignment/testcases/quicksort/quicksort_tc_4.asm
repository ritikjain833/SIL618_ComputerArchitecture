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
	mov r1, 242
	st r1, 0[r0]
	mov r1, 54
	st r1, 4[r0]
	mov r1, 204
	st r1, 8[r0]
	mov r1, 156
	st r1, 12[r0]
	mov r1, 32
	st r1, 16[r0]
	mov r1, -84
	st r1, 20[r0]
	mov r1, -47
	st r1, 24[r0]
	mov r1, -70
	st r1, 28[r0]
	mov r1, -89
	st r1, 32[r0]
	mov r1, -67
	st r1, 36[r0]
	mov r1, 145
	st r1, 40[r0]
	mov r1, -216
	st r1, 44[r0]
	mov r1, -144
	st r1, 48[r0]
	mov r1, -19
	st r1, 52[r0]
	mov r1, -174
	st r1, 56[r0]
	mov r1, 17
	st r1, 60[r0]
	mov r1, -131
	st r1, 64[r0]
	mov r1, -179
	st r1, 68[r0]
	mov r1, -106
	st r1, 72[r0]
	mov r1, -205
	st r1, 76[r0]
	mov r1, 101
	st r1, 80[r0]
	mov r1, -169
	st r1, 84[r0]
	mov r1, -133
	st r1, 88[r0]
	mov r1, -24
	st r1, 92[r0]
	mov r1, 224
	st r1, 96[r0]
	mov r1, -69
	st r1, 100[r0]
	mov r1, -61
	st r1, 104[r0]
	mov r1, 177
	st r1, 108[r0]
	mov r1, -23
	st r1, 112[r0]
	mov r1, 7
	st r1, 116[r0]
	mov r1, -94
	st r1, 120[r0]
	mov r1, 193
	st r1, 124[r0]
	mov r1, 97
	st r1, 128[r0]
	mov r1, 112
	st r1, 132[r0]
	mov r1, -52
	st r1, 136[r0]
	mov r1, 53
	st r1, 140[r0]
	mov r1, -180
	st r1, 144[r0]
	mov r1, 60
	st r1, 148[r0]
	mov r1, 237
	st r1, 152[r0]
	mov r1, 131
	st r1, 156[r0]

	mov r2, 0 @ Starting address of the array

	@ Retreive the end address of the array
	mov r3, 39
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
	ld r1, 80[r0]
	.print r1
	ld r1, 84[r0]
	.print r1
	ld r1, 88[r0]
	.print r1
	ld r1, 92[r0]
	.print r1
	ld r1, 96[r0]
	.print r1
	ld r1, 100[r0]
	.print r1
	ld r1, 104[r0]
	.print r1
	ld r1, 108[r0]
	.print r1
	ld r1, 112[r0]
	.print r1
	ld r1, 116[r0]
	.print r1
	ld r1, 120[r0]
	.print r1
	ld r1, 124[r0]
	.print r1
	ld r1, 128[r0]
	.print r1
	ld r1, 132[r0]
	.print r1
	ld r1, 136[r0]
	.print r1
	ld r1, 140[r0]
	.print r1
	ld r1, 144[r0]
	.print r1
	ld r1, 148[r0]
	.print r1
	ld r1, 152[r0]
	.print r1
	ld r1, 156[r0]
	.print r1