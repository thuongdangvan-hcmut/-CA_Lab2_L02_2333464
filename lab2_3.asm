.data
msg1:      .asciiz "Nhap mang so nguyen 10 phan tu\n"
msg2:      .asciiz "Please insert a element: "
msg3:      .asciiz "Khong co so lon nhi trong mang"
msg4:      .asciiz "Second largest value is "
msg5:      .asciiz "\nfound in index"
space:     .asciiz " "

.align 2
arr:       .space 40      # 10 integers = 40 bytes

.text
.globl main

main:

# ======================
# Nhap mang
# ======================
li $v0, 4
la $a0, msg1
syscall

la $s0, arr      # dia chi mang
li $t0, 0        # i = 0

input_loop:
    beq $t0, 10, find_max

    li $v0, 4
    la $a0, msg2
    syscall

    li $v0, 5
    syscall

    sll $t1, $t0, 2
    add $t2, $s0, $t1
    sw $v0, 0($t2)

    addi $t0, $t0, 1
    j input_loop

# ======================
# gia tri lon nhat
# ======================
find_max:
    lw $s1, 0($s0)      # s1 = gt_max

    li $t0, 0

max_loop:
    beq $t0, 10, find_tam

    sll $t1, $t0, 2
    add $t2, $s0, $t1
    lw $t3, 0($t2)

    ble $t3, $s1, next_max

    move $s1, $t3

next_max:
    addi $t0, $t0, 1
    j max_loop

# ======================
# khoang cach nho nhat => so lon nhi
# ======================
find_tam:
    lw $t3, 0($s0)
    sub $s2, $s1, $t3      # s2 = tam

    li $t0, 0

distance_loop:
    beq $t0, 10, check_result

    sll $t1, $t0, 2
    add $t2, $s0, $t1
    lw $t3, 0($t2)

    sub $t4, $s1, $t3      # gt_khoangcach

    blez $t4, next_dist

    bge $t4, $s2, next_dist

    move $s2, $t4

next_dist:
    addi $t0, $t0, 1
    j distance_loop

# ======================
# so lon nhi va vi tri cua so do
# ======================
check_result:
    blez $s2, no_second

    sub $s3, $s1, $s2      # gt_sdmax

    li $v0, 4
    la $a0, msg4
    syscall

    li $v0, 1
    move $a0, $s3
    syscall

    li $v0, 4
    la $a0, msg5
    syscall

    li $t0, 0

print_index:
    beq $t0, 10, exit

    sll $t1, $t0, 2
    add $t2, $s0, $t1
    lw $t3, 0($t2)

    bne $t3, $s3, next_index

    li $v0, 4
    la $a0, space
    syscall

    li $v0, 1
    move $a0, $t0
    syscall

next_index:
    addi $t0, $t0, 1
    j print_index

# ======================
# Khong co so lon nhi
# ======================
no_second:
    li $v0, 4
    la $a0, msg3
    syscall

# ======================
# Ket thuc
# ======================
exit:
    li $v0, 10
    syscall