# Lab 1-2

.globl _start 

.data 
arr: .word -1, 22, 8, 35, 5, 4, 11, 2, 1, 78
hi: .byte 9
lo: .byte 0
k: .byte 2     		 # the position of the pivot 
newline: .string "\n"
comma: .string " ,"


.text 
_start:
	la a1, arr       # a0 stores the address of the fist element 
	lb a2, lo        # a2 = lo
	lb a3, hi        # a3 = hi
	lb a4, k         # a4 = k 
	
	slli s9,a4, 2    # s9 = the offset of arr[k] relative to arr[0]
	add s9, a1,s9    # s9 = the address of arr[k]
	lw t0, 0(s9)     # t0 = arr[k]  
	
	slli s8,a3, 2    # s8 = the offset of arr[hi] relative to arr[0]
	add s8,a1,s8     # s8 = the address of arr[hi]
	lw t4, 0(s8)     # t4 = arr[hi]
	
	sw t4, 0(s9)     # store the value of arr[hi] to the address of arr[k] 
	sw t0, 0(s8)     # store the value of arr[k] to the address of arr[hi]
	lw t0, 0(s8)     # t0 = arr[hi] = pivot 
	
	
	
	# function Partition(arr, lo, hi)
        # pivot = A[k]
        # i = lo-1;
        # for j = lo; j <= hi-1; j = j+1 do
        #	if A[j] = pivot then
        # 		i = i+1;
        # 		swap A[i] with A[j];
        # 	end if
        # end for
        # 	swap A[i+1] with A[hi];
        # 	return i+1;
        # end function
     
        # adjust stack pointer
    	addi sp, sp, -12
    	sw ra, 0(sp)
    	sw s10, 4(sp)      # s10 = the address of arr[i]
    	sw s11, 8(sp)      # s11 = the address of arr[j]
    	
    	addi t2, a2, -1    # t2 = i = low - 1
    	addi t5, a3, -1    # t5 = high - 1   
    	mv t6, a2 	   # t6 = j = lo 
    	
    	
    	partition_forloop:
    	# for j = lo; j <= hi-1; j = j+1 do
    	bgt t6, t5, partition_forloop_end  	   # if lo > hi-1, then partition_forloop_end
    		
    		slli s11,t6, 2 			  	   # t6 = the offset of arr[j] relative to arr[0]
        	add s11, a1, s11         	  	   # s11 = the address of arr[j]
        	lw t1, 0(s11)          	          	   # t1 = the value of arr[j]
        	
        	# if A[j] = pivot then
               	bgt t1, t0, partition_forloop_inner_skip  # if arr[j] > pivot, skip 
            		addi t2, t2, 1     			   # i++
            		# swap a[i] with a[j]
            		slli s10, t2, 2    			   # s10 = the offset of arr[i] relative to arr[0]
            		add s10, a1, s10  			   # s10 = the address of arr[i]
           	 	lw t3, 0(s10)    			   # t3 = arr[i]
            		sw t3, 0(s11)   			   # arr[j] = t3
            		sw t1, 0(s10)    			   # arr[i] = t1
      		partition_forloop_inner_skip:
 
      		
        	addi t6, t6, 1   			   # j++
    	j partition_forloop
     	partition_forloop_end:
     	
     	
	addi a0, t2, 1      			   # return value = i+1
	li a7,1            			   # load the number of system call = 1, print integer 
    	ecall 
    	la a0, newline     
	li a7, 4
	ecall 
	addi a0, t2, 1 
	
    	
    	# swap(&arr[i+1], &arr[high])
    	slli s10, a0, 2
    	add s10, s10, a1             # s10 = the address of arr[i+1]
    	slli s11, a3, 2
    	add s11, s11, a1             # s11 = the address of arr[hi]
    	lw t2, 0(s10)                # t2 = the value of arr[i+1]
    	lw t3, 0(s11)                # t3 = the value of arr[hi]
    	sw t2, 0(s11)
    	sw t3, 0(s10)

    	# adjust stack pointer back 
    	lw ra, 0(sp)
    	lw s10, 4(sp)
    	lw s11, 8(sp)
    	addi sp, sp, 12
    	
    	
lw a0, 0(a1)
li a7, 1 
ecall 
la a0, comma   
li a7, 4
ecall 
lw a0, 4(a1)
li a7, 1 
ecall 
la a0, comma   
li a7, 4
ecall
lw a0, 8(a1)
li a7, 1 
ecall 
la a0, comma   
li a7, 4
ecall
lw a0, 12(a1)
li a7, 1 
ecall 
la a0, comma   
li a7, 4
ecall
lw a0, 16(a1)
li a7, 1 
ecall 
la a0, comma   
li a7, 4
ecall
lw a0, 20(a1)
li a7, 1 
ecall 
la a0, comma   
li a7, 4
ecall
lw a0, 24(a1)
li a7, 1 
ecall 
la a0, comma   
li a7, 4
ecall
lw a0, 28(a1)
li a7, 1 
ecall 
la a0, comma   
li a7, 4
ecall
lw a0, 32(a1)
li a7, 1 
ecall 
la a0, comma   
li a7, 4
ecall
lw a0, 36(a1)
li a7, 1 
ecall 

    	
    	

    		
	
