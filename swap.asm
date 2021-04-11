# Lab 1-1 

.globl _start 

.data 
var1: .byte 15
var2: .byte 19
newline: .string "\n"


.text 
_start:
	li a7,34            # load the number of system call = 34, print integer in hexidecimal format 
	la a0, var1         # load the address of var1 to a1 
	mv s1, a0           # save the address of var1 to s1 
	lb t1, 0(s1)	    # load the value of var1 into t1  
	ecall               # execute the printInteger function 
	la a0, newline     
	li a7, 4
	ecall 

	li a7, 34 	    # load the number of system call = 34, print integer in hexidecimal format 
	la a0, var2         # load the address of var2 to a0  
	mv s2, a0           # save the address of var2 to s2 
	lb t2, 0(s2) 	    # load the value of var2 into t2
	ecall               # execute the printInteger function 
	la a0, newline     
	li a7, 4
	ecall 
	
	li a7,1             # load the number of system call = 1, print integer 
	addi a0, t1, 1      # var1 = var1 + 1 
	mv t3, a0           # t3 stores the new value of var1 
	ecall 		    # execute the printInteger function 
	la a0, newline     
	li a7, 4
	ecall 
	
	
	li a7, 1	    # load the number of system call = 1, print integer 
	slli a0, t2, 2	    # var2 = var2 * 4, equal to left shift 2 bits 
	mv t4, a0           # t4 stores the new value of var2 
	ecall               # execute the printInteger function 
	la a0, newline     
	li a7, 4
	ecall 
	
	
	sb t3, 0(s2)         # write the value of var2 to the address of var1 
	sb t4, 0(s1)         # write the value of var1 to the address of var2 
	
	li a7, 1	    # load the number of system call = 1, print integer 
	lb t3, 0(s1)
	add a0, t3, zero    
	ecall               # execute the printInteger function
	la a0, newline     
	li a7, 4
	ecall 
	
	li a7, 1	    # load the number of system call = 1, print integer 
	lb t4, 0(s2)
	add a0, t4, zero 
	ecall               # execute the printInteger function 
	la a0, newline     
	li a7, 4
	ecall 






