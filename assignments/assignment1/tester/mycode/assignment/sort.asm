.quicksort:
    cmp r4,r2
    bgt .continue
    b .end
    .continue:
        
        sub sp,sp,4
        st ra,[sp]
        b .partition
        ld ra,[sp]
        add sp,sp,4

        sub sp,sp,16
        st r2,[sp]
        st r3,4[sp]
        st r4,8[sp]
        st ra,12[sp]
       
        add r2,r3,4
        b .quicksort
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
        b .quicksort
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
	mov r1, 3	@ replace 12 with the number to be sorted
	st r1, 0[r0]
	mov r1, 15	@ replace 7 with the number to be sorted
	st r1, 4[r0]
	mov r1, 12 @ replace 11 with the number to be sorted
	st r1, 8[r0]
	mov r1, 6   @ replace 9 with the number to be sorted
	st r1, 12[r0]
	mov r1, 9   @ replace 3 with the number to be sorted
	st r1, 16[r0]
	mov r1, 7  @ replace 15 with the number to be sorted
	st r1, 20[r0]
	@ EXTEND ON SIMILAR LINES FOR MORE NUMBERS

	mov r2, 0          @ Starting address of the array
	
	@ Retreive the end address of the array
	mov r3, 5	@ REPLACE 5 WITH N-1, where, N is the number of numbers being sorted
    mul r3,r3,4
	add r4,r2,r3
	
	
 	@ ADD YOUR CODE HERE 

	call .quicksort

 	@ ADD YOUR CODE HERE

	@ Print statements for the result
	mov r3, 5      @ REPLACE 5 WITH N-1, where, N is the number of numbers being sorted 
    mov r2, 0      @ Starting address of the array
    .printLoop:
        ld r1, 0[r2]
        .print r1
        add r2,r2,4  @ Incrementing address value
        cmp r3, 0    @ r3 contains number of elements in array
        sub r3,r3,1  
        bgt .printLoop