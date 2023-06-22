# asm
#With Tran Van Duy 20215017..

.data
a:  .word -1, 150, 190, 170, -1, -1, 160, 180
b:  .word
.text
main:
# Find peoplE
	li $t1, 0		# index a: i = 0
	jal UP_i		# $t5 = 4i
	nop
	li $t2, 0		# index b: j = 0
	jal UP_j		# $t6 = 4j
	nop
	li $s0, 8		# n = 8
Check_a:
	slt $t0, $t1, $s0
	beq $t0, $zero, Sort_b	# if i >= 8 => Sort_b
	lw $s1, a($t5)	# Load a[i];
	bne $s1, -1, Insert_b	# if a[i] != -1 => Insert_b
	addi $t1, $t1, 1	# i = i + 1
	jal UP_i		# $t5 = 4i
	nop
	j Check_a
Insert_b:
	sw $s1, b($t6)	# Insert to b[i]
	addi $t2, $t2, 1	# j = j + 1
	jal UP_j		# $t6 = 4j
	nop
	addi $t4, $t2, 0	# n_b - 1 = j : s? ph?n t? c?a b
	addi $t1, $t1, 1	# i = i + 1
	jal UP_i		# $t5 = 4i
	nop
	j Check_a
Sort_b:
	li $t2, 0		# index b: j = 0
	addi $t4, $t4, -1	# nb = nb - 1
	beq $t4, 0, Insert_a	# n = 0 => Insert_a
loop1:
	slt $t0, $t2, $t4
	beq $t0, $zero, Sort_b	# if j >= n => Sort_b again
	jal UP_j		# $t6 = 4j
	addi $t3, $t2, 1	# j + 1
	add  $t7, $t3, $t3	# 2j
	add $t7, $t7, $t7	# 4j
	lw $s2, b($t6)	# s2 = b[j]
	lw $s3, b($t7)	# s3 = b[j+1]
	slt $t0, $s3, $s2	
	bne $t0, $zero, Swap# if b[j+1] < b[j] => Swap
	addi $t2, $t2, 1	# j = j + 1
	jal UP_j		# $t6 = 4j
	nop
	j loop1
Swap:
	addi $t0, $s2, 0	# temp = b[j]
	sw $s3, b($t6)	# b[j] = b[j+1]
	sw $t0, b($t7)	# b[j+1] = temp
	addi $t2, $t2, 1	# j = j + 1
	jal UP_j		# $t6 = 4j
	nop
	j loop1
Insert_a:
	li $t1, 0		# index a: i = 0
	jal UP_i		# 4i
	li $t2, 0		# index b: j = 0
	jal UP_j		# 4j
loop2:
	slt $t0, $t1, $s0
	beq $t0, $zero, Exit	# if i >= 8 => Print
	lw $s1, a($t5)	# s1 = a[i]
	bne $s1, -1, loop3	# if a[i] != -1 => loop3: insert people to a
	addi $t1, $t1, 1	# i = i + 1
	jal UP_i		# 4i
	nop
	j loop2 
loop3:
	lw $s2, b($t6)	# s2 = b[j]
	sw $s2, a($t5)	# store a[i] = b[j]
	addi $t2, $t2, 1	# j = j + 1
	jal UP_j		# 4j
	nop
	addi $t1, $t1, 1	# i = i + 1
	jal UP_i		# 4i
	j loop2
#--------------------------------------
UP_i:
	add $t5, $t1, $t1	# 2i
	add $t5, $t5, $t5	# 4i
	jr $ra
UP_j:
	add $t6, $t2, $t2	# 2i
	add $t6, $t6, $t6	# 4i
	jr $ra
Exit:
	li $v0, 10
	syscall	
