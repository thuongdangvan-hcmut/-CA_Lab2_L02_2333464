.data
msgA:      .asciiz "a="
msgB:      .asciiz "b="
msgGCD:    .asciiz "GCD="
msgLCM:    .asciiz "\nLCM="

.text
.globl main

main:

input:
    # nhập a
    li $v0, 4
    la $a0, msgA
    syscall

    li $v0, 5
    syscall
    move $s0, $v0      # a

    # nhập b
    li $v0, 4
    la $a0, msgB
    syscall

    li $v0, 5
    syscall
    move $s1, $v0      # b

    # kiem tra a, b nho hon 1
    blez $s0, input
    blez $s1, input

    # gọi UCLN(a,b)
    move $a0, $s0
    move $a1, $s1
    jal UCLN

    move $s2, $v0      # GCD

    # LCM = a*b/GCD
    mult $s0, $s1
    mflo $t0

    div $t0, $s2
    mflo $s3           # LCM

    # in GCD
    li $v0, 4
    la $a0, msgGCD
    syscall

    li $v0, 1
    move $a0, $s2
    syscall

    # in LCM
    li $v0, 4
    la $a0, msgLCM
    syscall

    li $v0, 1
    move $a0, $s3
    syscall

    # kết thúc
    li $v0, 10
    syscall

#################################################
# int UCLN(int a, int b)
#################################################
UCLN:

    # lưu stack
    addi $sp, $sp, -12
    sw $ra, 8($sp)
    sw $a0, 4($sp)
    sw $a1, 0($sp)

    # if(a==b)
    beq $a0, $a1, equal

    # if(a>b)
    bgt $a0, $a1, a_greater

    # else b=b-a
    sub $a1, $a1, $a0
    jal UCLN
    j finish

a_greater:
    sub $a0, $a0, $a1
    jal UCLN
    j finish

equal:
    move $v0, $a0

finish:
    lw $a1, 0($sp)
    lw $a0, 4($sp)
    lw $ra, 8($sp)
    addi $sp, $sp, 12

    jr $ra