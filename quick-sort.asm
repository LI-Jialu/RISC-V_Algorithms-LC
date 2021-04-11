.global _start


.data
arr: .word -1, 22, 8, 35, 5, 4, 11, 2, 1, 78
hi: .byte 9
lo: .byte 0
comma: .string " ,"
    

.text

_start:
la a1, arr         # a0 stores the address of the fist element 
lb a2, lo          # a2 = lo
lb a3, hi          # a3 = hi
	
jal ra, quicksort  # jump to quicksort 


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


	
li a7, 93 
ecall 

    	
# quicksort(*arr, lo, hi)
# arr -> a1
# lo -> a2
# hi -> a3
quicksort:
    blt a3, a2, quicksort_exit      # if lo >= hi, return
    
    # adjust stack pointer 
    addi sp, sp, -16
    sw ra, 0(sp)        # save the return address 
    sw s10, 4(sp)       # save s10 on stack for storing lo
    sw s11, 8(sp)       # save s11 on stack for storing hi
    sw s9, 12(sp)       # save s9 on stack for storing pivot

    # hold lo and hi
    mv s10, a2          # s10 <- lo
    mv s11, a3          # s11 <- hi
  		 
    # call partition for the whole array 
    jal ra, partition
    # save the position of the pivot on s9
    mv s7, a0

    # call quicksort on the left hand side subarrays
    addi a3, s7, -1         # hi = pivot (-1)
    mv a2, s10		    # lo = lo
    jal ra, quicksort       # quicksort(a1, lo, pivot-1)
		
    # call partition on the right  hand side array 
    addi a2, s7, 1          # lo = pivot (+1)
    mv a3, s11              # hi = hi
    jal ra, quicksort       # quicksort(a2, pivot+1, hi)

    # adjust the stack pointer back 
    lw ra, 0(sp)
    lw s10, 4(sp)
    lw s11, 8(sp)
    lw s9, 12(sp)
    addi sp, sp, 16

quicksort_exit:
    ret


     partition:
        # adjust stack pointer
    	addi sp, sp, -12
    	sw ra, 0(sp)
    	sw s10, 4(sp)      # s10 = the address of arr[i]
    	sw s11, 8(sp)      # s11 = the address of arr[j]
    	
    	addi t2, a2, -1    # t2 = i = low - 1
    	addi t5, a3, -1    # t5 = high - 1   
    	mv t6, a2 	   # t6 = j = lo 
    	
    	slli s7, a3, 2
    	add s7, a1, s7
    	lw t0, 0(s7)
    	
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
    	
    partition_finished:
    jalr x0, 0(ra)
    	
    	