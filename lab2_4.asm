.data
msg1:   .asciiz "Nhap so nguyen khong am a: "
msg2:   .asciiz "A factorial for your number can not be found"
newline:.asciiz "\n"

.text
.globl main

main:
    # In thong bao nhap
    li $v0, 4
    la $a0, msg1
    syscall

    # Nhap a
    li $v0, 5
    syscall
    move $t0, $v0      # $t0 = a

    # Kiem tra a < 0
    bltz $t0, negative

    # giaithua = 1
    li $t1, 1          # $t1 = giaithua

    # i = 1
    li $t2, 1          # $t2 = i

loop:
    bgt $t2, $t0, print_result

    mul $t1, $t1, $t2 # giaithua *= i
    addi $t2, $t2, 1  # i++

    j loop

negative:
    li $v0, 4
    la $a0, msg2
    syscall
    j end_program

print_result:
    li $v0, 1
    move $a0, $t1
    syscall

end_program:
    li $v0, 10
    syscall