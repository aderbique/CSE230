###########################################################
# Assignment #: 2
#  Name: Austin Derbique
#  ASU email: aderbiqu@asu.edu
#  Course: CSE/EEE230, TH 6-7:15pm
#  Description: MIPS assembly language program that adds the following two integers and displays the sum and the difference.
###########################################################

#data declarations: declare variable names used in program, storage allocated in RAM
                            .data  
num1:         .word 91543 #Initialize num1 to the value 91543 in base 10
num2:         .word 0xD8C #Intiialize num2 to the value D8C in base 16
message1:     .asciiz "num1 is : "
message2:     .asciiz "\nnum2 is : "
message3:     .asciiz "\nnum1+num2 = "
message4:     .asciiz "\nnum1-num2 = "

#program code is contained below under .text
                        .text
                        .globl    main    #define a global function main

# the program begins execution at main()
main:
                                        # message 1
            la          $a0, message1   # $a0 = address of message1
            li          $v0, 4          # $v0 = 4  --- this is to call print_string()
            syscall                     # call print_string() to say 'num1 is : '

                                        # num 1
            la          $a0, num1       # $a0 = address of num1
            lw          $t0, 0($a0)     # load in word num1
            move        $a0, $t0        # copy $t0 into $a0
            li          $v0, 1          # prepare to call print_int()
            syscall                     # call print_int()

                                        # message 2
            la          $a0, message2   # $a0 = address of message1
            li          $v0, 4          # this is to call print_string()
            syscall                     # call print_string() to say 'num2 is : '

                                        # num 2
            la		    $a0, num2       # $a0 = address of num2
            lw          $t1, 0($a0)     # $s2 = $a0     load in word num2
            move        $a0, $t1        # copy $t1 into $a0
            li		    $v0, 1		    # $v0 = 4       prepare to call print_string()
            syscall                     # call print_string()

                                        # message 3
            la          $a0, message3   # $a0 = address of message3
            li          $v0, 4          # this is to call print_string()
            syscall                     # call print_string() to say 'num1+num2 = '

                                        # num1+num2
            add         $a0, $t0, $t1   # $t3 = $t1 + $t2
            li          $v0, 1          # prepare to call print_int()
            syscall                     # call print_int()

                                        # message 4        
            la          $a0, message3   # $a0 = address of message3
            li          $v0, 4          # this is to call print_string()
            syscall                     # call print_string() to say 'num1-num2 = '

                                        # num1-num2
            sub         $a0, $t0, $t1   # $t3 = $t1 - $t2
            li          $v0, 1          # prepare to call print_int()
            syscall                     # call print_int()

            jr          $ra             # return