	.data
alloc: .space 32  # this will allocate the given input 
temp: 	.space 32 
p:	.word 0
number: .asciiz "give a number from 2,4,8,16 or 32 "
get: 	.asciiz	"give a number "
done:	.asciiz " Thank you for the input "
comma:	.asciiz ", "

	.text
	.globl main
	
main:
	li $v0,4
	la $a0,number #promting to get the size of the array
	syscall
	li $v0,5
	syscall
	move $t7,$v0 #length
	li $t0,0#this will be the counter to get the inputs stor in $t1
		

	li $t1,0
	
input: 	
	li $v0,4
	la $a0,get #promting to get tuhe allocate space
	syscall
	li $v0,5
	syscall
	sw $v0,temp($t1)  #stores the unout in a dynamic heap 
	addi $t1,$t1,4
	addi $t0,$t0,1
	 bne $t0,$t7,input 
	li $v0,4 
	la $a0,done
	syscall 
	sll $s2,$t7,2 #last pointer
	#lw $s0,$t0
	#s2 & s3 be  pointers 
	#li $s4,0
	#li $s6,0 
	li $s0,0
	li $s1,4
	li $v1,0
	li $t6,0
	addi $t5,$t7,0
	addi $t7,$t7,1
merge:
	#out of bound conditions
	lw $t0,temp($s0)
	lw $t1, temp($s1)
	bgeu  $s0,$s2,out0
	bge  $s1,$s2,out1
	bge $t0,$t1,swap#work
	add $s1,$s1,4
	addi $t2,$zero,0
	bge $t6,$t7,print
	j merge
	#bleu $v1,$t0,Left
	#j Right

swap:
	sw $t0,temp($s1)
	sw $t1,temp($s0)
	addi $s0,$s0,8
	addi $s1,$s0,4
	j merge 
out0:
	addi $s0,$zero,0
	addi $s1,$s0,4
	addi $t6,$t6,1
	bge $t6,$t7,print
	j merge
out1:
	addi $s0,$s0,4
	addi $s1,$s0,4
	j merge 
print:
	beqz  $t5,Exit #exit condion when the array reaches the end 
	lw $t6,temp($t2)
	add $t2,$t2,4
	sub $t5,$t5,1
	#print the cu`rrent digit value
	li $v0,1
	move $a0,$t6
	syscall
	#print the comma
	li $v0,4
	la $a0,comma
	syscall
	j print
Exit:
