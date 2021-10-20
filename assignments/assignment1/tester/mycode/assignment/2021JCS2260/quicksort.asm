.quicksort:
    cmp r4,r2               @high>low
    bgt .continue           @if low<high
    b .end                  @else
    .continue:     
        
        sub sp,sp,4         @reserve space for Return address register 
        st ra,[sp]          @store ra
        call .partition     @partition(arr,low,high)
        ld ra,[sp]          @load value after partition function call
        add sp,sp,4         @remove stack space

        sub sp,sp,16        @create stack for low,mid,high and ra respectively
        st r2,[sp]          @store low
        st r3,4[sp]         @store mid
        st r4,8[sp]         @store high
        st ra,12[sp]        @store ra
       
        add r2,r3,4         @low=mid+1
        call .quicksort     @quicksort(arr,mid+1,high)
        ld r2,[sp]          @load low
        ld r3,4[sp]         @load mid
        ld r4,8[sp]         @load high
        ld ra,12[sp]        @load ra
        add sp,sp,16        @remove space for stack
        sub sp,sp,16        @create stack space for low,mid,high and ra respectively
        st r2,[sp]          @store low
        st r3,4[sp]         @store mid
        st r4,8[sp]         @store high
        st ra,12[sp]        @store ra
        sub r4,r3,4         @high=mid-1
        call .quicksort     @quicksort(arr,start,mid-1)
        ld r2,[sp]          @load low
        ld r3,4[sp]         @load mid
        ld r4,8[sp]         @load high
        ld ra,12[sp]        @load ra
        add sp,sp,16        @remove stack space
    .end:
        ret
.partition:
    ld r10,[r4]             @pivot=arr[high]
    sub r5,r2,4             @initialize i=start-1
    mov r6,r2               @initialize j=start
    .loop:                  @for(j=start;j<=high-1;j++)    
        cmp r6,r4           @compare j and high
        beq .end1           @if j==high break
        ld r7,[r6]          @load arr[j] in r7
        cmp r10,r7          @compare arr[j] and pivot element 
        bgt .swap           @if pivot>arr[j]  swap arr[j] and arr[i]
        beq .swap           @if pivot=arr[j]  swap arr[j] and arr[i]
        b .increment        @increment j
        .swap:              @swap function
            add r5,r5,4     @i=i+1
            ld r8,[r5]
            ld r9,[r6]
            add r8,r8,r9    @a=a+b
            sub r9,r8,r9    @b=a-b
            sub r8,r8,r9    @a=a-b
            st r8,[r5]
            st r9,[r6]
        .increment:
            add r6,r6,4     @j=j+1
            b .loop
    .end1:
        ld r8,[r4]          @swap arr[i+1] and arr[high]
        ld r9,4[r5]       
        add r8,r8,r9        @a=a+b
        sub r9,r8,r9        @b=a-b
        sub r8,r8,r9        @a=a-b
        st r8,[r4]
        st r9,4[r5]
        add r3,r5,4         @return i+1
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