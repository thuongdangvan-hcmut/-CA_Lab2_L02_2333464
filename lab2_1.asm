.data
msg1:       .asciiz "Nhap mang so nguyen 5 phan tu\n"
msg2:       .asciiz "\nNhap phan tu thu "
msg3:       .asciiz ": "
space:      .asciiz " "
newline:    .asciiz "\n"
.align 2
arr:        .space 20          # 5 so nguyen (5 * 4 bytes)

.text
.globl main

main:
    # In thong bao nhap mang
    li $v0, 4
    la $a0, msg1
    syscall

    # i = 0
    li $t0, 0

input_loop:
    beq $t0, 5, print_original

    # In "Nhap phan tu thu "
    li $v0, 4
    la $a0, msg2
    syscall

    # In i+1
    li $v0, 1
    addi $a0, $t0, 1
    syscall

    # In ": "
    li $v0, 4
    la $a0, msg3
    syscall

    # Doc so nguyen
    li $v0, 5
    syscall

    # gan so nguyen vao ptu mang
    sll $t1, $t0, 2
    la $t2, arr
    add $t2, $t2, $t1
    sw $v0, 0($t2)

    addi $t0, $t0, 1
    j input_loop

#################################################
# In mang goc
#################################################
print_original:
    li $t0, 0

print_loop:
    beq $t0, 5, adjust_array

    sll $t1, $t0, 2
    la $t2, arr
    add $t2, $t2, $t1
    lw $a0, 0($t2)

    li $v0, 1
    syscall

    li $v0, 4
    la $a0, space
    syscall

    addi $t0, $t0, 1
    j print_loop

#################################################
# Xu ly va in mang moi
#################################################
adjust_array:
    li $v0, 4
    la $a0, newline
    syscall

    li $t0, 0

adjust_loop:
    beq $t0, 5, exit

    sll $t1, $t0, 2
    la $t2, arr
    add $t2, $t2, $t1
    lw $t3, 0($t2)

    # ptu chia  4
    li $t4, 4
    div $t3, $t4
    mfhi $t5

    # du 3 -> tang 1
    li $t6, 3
    beq $t5, $t6, plus1

    # du 2 -> giam 2
    li $t6, 2
    beq $t5, $t6, minus2

    # du 1 -> giam 1
    li $t6, 1
    beq $t5, $t6, minus1

    j print_adjusted

plus1:
    addi $t3, $t3, 1
    j save_value

minus2:
    addi $t3, $t3, -2
    j save_value

minus1:
    addi $t3, $t3, -1

save_value:
    sw $t3, 0($t2)

print_adjusted:
    li $v0, 1
    move $a0, $t3
    syscall

    li $v0, 4
    la $a0, space
    syscall

    addi $t0, $t0, 1
    j adjust_loop

exit:
    li $v0, 10
    syscall