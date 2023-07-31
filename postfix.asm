.data
Input: .space 300
Xau_Trung_To: .space 300
Xau_Hau_To: .space 300
stack: .space 300
Vi_tri_toan_tu: .word 300
new_line_out: .asciiz "\n"
.text
#--------------------------------------------------------------------------------
#main:
#chuẩn hóa đầu vào
	addi $s6, $zero, 0x20 	# $s6 = SPACE 
	li $v0, 8				#Input
	la $a0, Input  
	li $a1, 300
	syscall
	nop	

	
	la $a0, Input
	la $a1, Xau_Trung_To
	add $t1, $a1, $zero #là -1 do mình sẽ thêm một cách trước phần tử sắp lưu
	add $t0, $a0, $zero
	addi $t0, $t0, -1
	addi $t1, $t1, -2
	
loop0:
	addi $t0, $t0, 1
	lb $s0, 0($t0)
	beq $s0, 0x20 , loop0
	nop
	beq $s0, 0x6E, end_loop0
	nop
	beq $s0, $zero, end_loop0	
	nop
	beq $s0, 0x30, xac_dinh_co_phai_so_2_chu_so_hay_khong
	nop
	beq $s0, 0x31, xac_dinh_co_phai_so_2_chu_so_hay_khong
	nop
	beq $s0, 0x32, xac_dinh_co_phai_so_2_chu_so_hay_khong
	nop
	beq $s0, 0x33, xac_dinh_co_phai_so_2_chu_so_hay_khong
	nop
	beq $s0, 0x34, xac_dinh_co_phai_so_2_chu_so_hay_khong
	nop
	beq $s0, 0x35, xac_dinh_co_phai_so_2_chu_so_hay_khong
	nop
	beq $s0, 0x36, xac_dinh_co_phai_so_2_chu_so_hay_khong
	nop
	beq $s0, 0x37, xac_dinh_co_phai_so_2_chu_so_hay_khong
	nop
	beq $s0, 0x38, xac_dinh_co_phai_so_2_chu_so_hay_khong
	nop
	beq $s0, 0x39, xac_dinh_co_phai_so_2_chu_so_hay_khong
	nop
	addi $t1, $t1, 1
	sb $s6, 0($t1)  #lưu dấu cách
	addi $t1, $t1, 1
	sb $s0, 0($t1) #lưu phần tử khác cách

	j loop0
	nop
xac_dinh_co_phai_so_2_chu_so_hay_khong:
	addi $t1, $t1, 1
	sb $s6, 0($t1)  #lưu dấu cách
	addi $t1, $t1, 1
	sb $s0, 0($t1) #lưu phần tử khác cách
	addi $t0, $t0, 1
	lb $s0, 0($t0)
	beq $s0, 0x30, so_2_chu_so
	nop
	beq $s0, 0x31, so_2_chu_so
	nop
	beq $s0, 0x32, so_2_chu_so
	nop
	beq $s0, 0x33, so_2_chu_so
	nop
	beq $s0, 0x34, so_2_chu_so
	nop
	beq $s0, 0x35, so_2_chu_so
	nop
	beq $s0, 0x36, so_2_chu_so
	nop
	beq $s0, 0x37, so_2_chu_so
	nop
	beq $s0, 0x38, so_2_chu_so
	nop
	beq $s0, 0x39, so_2_chu_so
	nop
	addi $t0, $t0, -1
	j loop0
	nop
so_2_chu_so:
	addi $t1, $t1, 1	
	sb $s0, 0($t1)
	j loop0
	nop
	
end_loop0:	
	
#------------------------------------------------------------------------------------------
#xóa dấu xuống dòng ở input
	la $a0, Xau_Trung_To
	add $s0, $zero, $a0
new_line:
	lb $t0, 0($s0)
	addi $s0, $s0, 1
	beq $t0, 0x6E, xoa_new_line
	nop
	beq $t0, 0x0A, xoa_new_line
	nop
	j new_line
	nop
xoa_new_line:
	addi $s0, $s0, -1
	sb $zero, 0($s0)
	
#chuyển hậu tố
	la $a0, Xau_Trung_To
	la $a2, Xau_Hau_To
	la $a1, stack		#$a1 là đáy stack
	add $s0, $zero, $a1 # $s0 là địa chỉ đỉnh stack đầu tiên 
	add $t0, $zero, $a0 #$t0 chứa địa chỉ hiện tai của xâu trung tố
	add $t1, $zero, $a2 #$t1 chứa địa chỉ hiện tại của xâu hậu tố 
	
	lb $t2, 0($t0)#$t2 chứa giá trị 1 kí tự trước
xu_ly_ki_tu: 
#nếu là ngoặc
	beq $t2, 0x28, ngoac_mo #((((((((((
	nop
	beq $t2, 0x29, ngoac_dong    #))))))))))
	nop
#không là ngoặc	
	j khong_phai_ngoac         #1234*+^
	nop
	
continue0:	
	addi $t0, $t0, 2 #tăng con trỏ địa chỉ lên 2
	lb $t2, 0($t0)#$t2 chứa giá trị kí tự tiếp 
	beq $t2, 0x6E, ket_thuc_xu_ly_ki_tu# phần tử tiếp theo
	nop
	beq $t2, $zero, ket_thuc_xu_ly_ki_tu# phần tử tiếp theo
	nop
	j xu_ly_ki_tu#  quay lại
	nop					         #1234*+^
ket_thuc_xu_ly_ki_tu: #kết thúc chuyển hậu tố

lay_dau_trong_stack:
	sub $s1, $s0, $a1
	jal out_stack # lấy phần tử đỉnh con trỏ đã trừ
	nop	
	sb $t6, 0($t1)		#gán vào xâu hậu tố	
	jal add_space_hau_to  #thêm cách
	nop
	bltz $s1, 	stack_rong		# kiểm tra điều kiện kết thúc 
#	addi $s1, $s1, 
	j lay_dau_trong_stack
	nop
stack_rong:
#in xâu hậu tố
	li $v0, 4
	la $a0, Xau_Hau_To
	syscall
	nop
#in xuống dòng
	li $v0, 4
	la $a0, new_line_out
	syscall
	nop

#------------------------------------------------------------------------------------------	
	
	la $a0, Xau_Hau_To
	la $a1, Vi_tri_toan_tu
	add $s0, $a0, $zero
	add $s1, $a1, $zero
	addi $s1, $s1, -4
	
	add $s6, $zero, 0x20 
	add $s7, $zero, 0x6F
	
	
#duyệt vị xâu hậu tố từ phần tử đầu tiên
duyet_xau_hau_to:
	lb $t0, 0($s0)
	beq $t0, $zero, in_ket_qua
	nop
	bne $t0, $s6, duyet_tiep
	nop
	addi $s0, $s0, 1
	j duyet_xau_hau_to
	nop
duyet_tiep:
	beq $t0, 0x5E, lay_toan_tu #^
	nop 
	beq $t0, 0x2B, lay_toan_tu  #+
	nop
	beq $t0, 0x2D, lay_toan_tu #-
	nop 
	beq $t0, 0x2A, lay_toan_tu	#*
	nop 
	beq $t0, 0x2F, lay_toan_tu #/
	nop 
	beq $t0, 0x25, lay_toan_tu #%
	nop 	
	beq $t0, 0x7E, lay_toan_tu #-
	nop 
	
	addi $s0, $s0, 1
	j duyet_xau_hau_to
	nop
in_ket_qua:

	li $v0, 1
	move $a0, $s5
	syscall
#thoát
	li $v0, 10
	syscall
	nop
endmain:

#-------------------------------------------------------------------------------- 
ngoac_dong:
	jal out_stack #lấy phần tử đầu tiên của stack
	nop
	beq $t6, 0x28, ket_thuc_ngoac_dong # gặp mở ngoặc thì kết thúc
	nop
	sb $t6, 0($t1)#nếu không phải là mở ngoạc thì ghi giá trị ra xâu hậu tố #yêu cầu thêm SPACE
	jal add_space_hau_to                      #đã thêm SPACE
	nop
	j ngoac_dong
	nop
ket_thuc_ngoac_dong:

	j continue0
	nop
ngoac_mo:	
	jal in_stack #lưu ngoạc mở vào stack
	nop
	j continue0
	nop
#((((((((((((((((((((((((((((((((

#stack
in_stack:
	sb $t2, 0($s0)
	addi $s0, $s0, 1 #tăng con trỏ stack thêm 1
	jr $ra
out_stack:
	addi $s0, $s0, -1  # giảm con trỏ stack đi 1 để trỏ vào đỉnh
	lb $t6, 0($s0)
	jr $ra
#stack


#SpaceSpaceSpaceSpaceSpaceSpaceSpaceSpace  ## $s6 = SPACE
add_space_hau_to:
	sb $s6, 1($t1) #thêm space sau phần tử được lưu của xâu hậu tố 
	addi $t1, $t1, 2#sau SPACE 
	jr $ra
#SpaceSpaceSpaceSpaceSpaceSpaceSpaceSpace

#1234*+^99999999999******************			 
khong_phai_ngoac:
	beq $t2, 0x5E, toan_tu_cap_3 #^
	nop 
	beq $t2, 0x2B, toan_tu_cap_1  #+
	nop
	beq $t2, 0x2D, toan_tu_cap_1 #-
	nop 
	beq $t2, 0x2A, toan_tu_cap_2 #*
	nop 
	beq $t2, 0x2F, toan_tu_cap_2 #/
	nop 
	beq $t2, 0x25, toan_tu_cap_2 #%
	nop 	
	beq $t2, 0x7E, toan_tu_cap_1 #-
	nop 
	
#không phải toán tử => xets toán hạng
#9999999999999999
	sb $t2, 0($t1)  #yêu cầu thêm SPACE
	addi $t0, $t0, 1# xét phần tử kế của trung tố
	lb $t3, 0($t0) #$t3 = giá trị tiếp theo của $t2
	bne $t3, $s6, la_toan_hang # $t3 khác dấu cách thì lưu $t3 vào hậu tố
	nop
	addi $t0, $t0, -1#xét phần tử kế của hậu tố
	jal add_space_hau_to  #đã thêm SPACE
	nop
	j continue0#  quay lại
	nop
	
la_toan_hang: #lưu $t2 vào xâu hậu tố do tiếp sau là dấu cách
	addi $t1, $t1, 1#lưu $t3 vào địa chỉ tiếp của sâu hậu tố
	sb $t3, 0($t1)  #yêu cầu thêm SPACE
	jal add_space_hau_to #đã thêm SPACE
	nop
	j continue0
	nop	
#9999999999999999
#9999999999999999********************




#*****^^^^^^^^^^^^^^^  #không có toán tử của ^ là khong_co_3#không có toán tử của *, /, % là khong_co_2#không có toán tử của +, - là khong_co_1

toan_tu_cap_1:
	jal out_stack
	nop
	beq $t6, 0x2A, luu_dinh_stack_vao_xau_hau_to_1
	nop
	beq $t6, 0x2F, luu_dinh_stack_vao_xau_hau_to_1
	nop
	beq $t6, 0x25, luu_dinh_stack_vao_xau_hau_to_1
	nop
	beq $t6, 0x5E, luu_dinh_stack_vao_xau_hau_to_1
	nop
	beq $t6, 0x2B, luu_dinh_stack_vao_xau_hau_to_1
	nop
	beq $t6, 0x2D, luu_dinh_stack_vao_xau_hau_to_1
	nop
	beq $t2, 0x7E, toan_tu_cap_1 #-
	nop 


	j luu_t2_vao_dinh_stack
	nop
toan_tu_cap_2:
	jal out_stack
	nop
	beq $t6, 0x2A, luu_dinh_stack_vao_xau_hau_to_2
	nop
	beq $t6, 0x2F, luu_dinh_stack_vao_xau_hau_to_2
	nop
	beq $t6, 0x25, luu_dinh_stack_vao_xau_hau_to_2
	nop
	beq $t6, 0x5E, luu_dinh_stack_vao_xau_hau_to_2
	nop
	
	j luu_t2_vao_dinh_stack
	nop
toan_tu_cap_3:
	jal out_stack
	nop	
	beq $t6, 0x5E, luu_dinh_stack_vao_xau_hau_to_3 # kiểm tra đã kết thúc kiểm tra toán tử hay chưa
	nop
	#lưu đỉnh stack vào hậu tố
	j luu_t2_vao_dinh_stack
	nop
#*****^^^^^^^^^^^^^^^

#lưu đỉnh stack vào xâu hậu tố
luu_dinh_stack_vao_xau_hau_to_3:
	sb $t6, 0($t1)
	jal add_space_hau_to
	nop
	j toan_tu_cap_3
	nop
luu_dinh_stack_vao_xau_hau_to_2:
	sb $t6, 0($t1)
	jal add_space_hau_to
	nop
	j toan_tu_cap_2
	nop
luu_dinh_stack_vao_xau_hau_to_1:
	sb $t6, 0($t1)
	jal add_space_hau_to
	nop
	j toan_tu_cap_1
	nop
	
	
#lưu $t2 vào đỉnh stack
luu_t2_vao_dinh_stack:
	addi $s0, $s0, 1 # con trỏ stack phải thêm 1 do hiện tại đỉnh stack đang có phần tử không được thêm
	jal in_stack # lưu $t2 vào stack
	nop
	j continue0 
	nop
lay_toan_tu:
	add $s2, $s0, $zero
load_s4:
	addi $s2, $s2, -1
	lb $t2, 0($s2)
	beq $t2, 0x20, load_s4
	nop
	beq $t2, 0x6F, s4_la_f
	nop
	sub $t2, $t2, 0x30 #lấy được giá trị 
	addi $s2, $s2, -1
	lb $t3, 0($s2)
	beq $t3, 0x20, luu_s4
	nop
	sub $t3, $t3, 0x30
	mul $t3, $t3, 10
	add $s4, $t3, $t2
	j load_s3
	nop
s4_la_f:
	lw $s4, 0($s1)
	addi $s1, $s1, -4
	j load_s3
	nop
luu_s4:
	add $s4, $zero, $t2
load_s3:
	addi $s2, $s2, -1
	lb $t2, 0($s2)
	beq $t2, 0x20, load_s3
	nop
	beq $t2, 0x6F, s3_la_f
	nop
	sub $t2, $t2, 0x30
	addi $s2, $s2, -1
	blt $s2, $a0, luu_s3 
	nop
	lb $t3, 0($s2)
	beq $t3, 0x20, luu_s3
	nop
	sub $t3, $t3, 0x30
	mul $t3, $t3, 10
	add $s3, $t2, $t3
	j tinh_toan5
	nop
s3_la_f:	
	lw $s3, 0($s1)
	addi $s1, $s1, -4
	j tinh_toan5
	nop
luu_s3:
	add $s3, $zero, $t2
tinh_toan5:
	beq $t0, 0x5E, mu1#^
	nop 
	beq $t0, 0x2B, cong1  #+
	nop
	beq $t0, 0x2D, tru1  #-
	nop 
	beq $t0, 0x2A, nhan1 #*
	nop 
	beq $t0, 0x2F, chia1 #/
	nop 
	beq $t0, 0x25, lay_du1 #%
	nop 
	
cong1:
	add $s5, $s3, $s4
	addi $s1, $s1, 4
	sw $s5, 0($s1)
	j gan_space_f
	nop
tru1:
	sub $s5, $s3, $s4
	addi $s1, $s1, 4
	sw $s5, 0($s1)
	j gan_space_f
	nop
nhan1:
	mul $s5, $s3, $s4
	addi $s1, $s1, 4
	sw $s5, 0($s1)
	j	gan_space_f
	nop
chia1:
	div $s5, $s3, $s4
	addi $s1, $s1, 4
	sw $s5, 0($s1)
	j gan_space_f
	nop
lay_du1:
	blt $s3, $s4, sau_khi_lay_du
	nop
	sub $s3, $s3, $s4
	j lay_du1
	nop
sau_khi_lay_du:
	add $s5, $s3, $zero
	addi $s1, $s1, 4
	sw $s5, 0($s1)
	j gan_space_f
	nop
mu1:
	add $t6, $s3, $zero
tinh_mu:
	addi  $s4, $s4, -1
	beq $s4, $zero, sau_khi_mu
	nop
	mul $s3, $s3, $t6
	j tinh_mu
	nop
sau_khi_mu:	
	add $s5, $s3, $zero
	addi $s1, $s1, 4
	sw $s5, 0($s1)
	j gan_space_f
	nop

gan_space_f:
	sb $s6, 0($s2) #gán cách
	addi $s2, $s2, 1
	bne $s2, $s0, gan_space_f
	nop
	sb $s7, 0($s0) # gán f tại vị trí của toán tử
	add $s0, $a0, $zero
	j duyet_xau_hau_to
	nop



	
