@bubble sort program
.bubble:
    sub r3,r3,1  @r3=n-1
    .loop1:
        cmp r2,r3     @ compare i with n-1
        beq .end1     @ end if i==n-1
        mov r4,0      @r4=j=0
        sub r5,r3,r2  @r5=n-1-i
        .loop2:
            cmp r4,r5    @ compare j with n-i-1
            beq .end2    @end if j==n-i-1
            mul r9,r4,4  @in r9 store r9=4*j
            ld r6,0[r9]  @load the value of arr[j] in r6
            ld r7,4[r9]  @load the value of arr[j+1] in r7
            cmp r6,r7   @ compare arr[j] and arr[j+1]
            bgt .swap   
            b .increment 
            .swap:              @if arr[j]>arr[j+1] swap arr[j] and arr[j+1]
                mul r8,r4,4   
                ld r10,0[r8]
                ld r11,4[r8]
                add r10,r10,r11  @ a=a+b
                sub r11,r10,r11  @b=a-b
                sub r10,r10,r11  @a=a-b
                st r10,0[r8]
                st r11,4[r8]
            .increment:
                add r4,r4,1  @ j=j+1
                b .loop2     @continue loop2
        .end2:
            add r2,r2,1   @i=i+1

            b .loop1      @continue loop1
    .end1:
        ret        @stop the bubblesort
@binarysearch program
.binarysearch:
    cmp r3,r2   @compare low and high
    beq .continue  @jump to continue if high>=low
    bgt .continue   
    b  .return      @exit if low>high
    .continue:  
        add r4,r2,r3  @temp= low+high
        div r4,r4,2   @mid=temp/2
        mul r5,r4,4     
        ld r6,0[r5]   @load the arr[mid] in r6.
        cmp r6,r0     @compare with target 
        beq .exit     @if arr[mid]==target element found
        bgt .update   @if arr[mid]>target
        b .less        @if arr[mid]<target
    .update:
        sub r3,r4,1     @high=mid-1
        b .binarysearch
    .less:
        add r2,r4,1
        b .binarysearch  @low=mid+1
.exit:
    mov r1,1
    ret
.return:
    ret


.main:
    mov r0,0
    mov r1,12
    st r1,0[r0]
    mov r1,7
    st r1,4[r0]
    mov r1,11
    st r1,8[r0]
    mov r1,9
    st r1,12[r0]
    mov r1,3
    st r1,16[r0]
    mov r1,15
    st r1,20[r0]
    mov r1,4
    st r1,24[r0]
    mov r3,7
    mov r2,0
    
    call .bubble
    mov r0,15
    mov r1,0
    mov r2,0
    mov r3,6
    call .binarysearch
    
    .print r1