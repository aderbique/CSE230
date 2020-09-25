###########################################################
# Assignment #: 7
#  Name: Austin Derbique
#  ASU email: aderbiqu@asu.edu
#  Course: CSE/EEE230, TH 6-7:15pm
#  Description: MIPS assembly language program that defines "main", and "function1" procedures. The main asks a user to enter an integer for n and calls the function1 by passing the n value, then prints the result.
###########################################################

#data declarations: declare variable names used in program, storage allocated in RAM
                            .data  
message1:     .asciiz "Enter an integer:\n"
message2:     .asciiz "The solution is: "
Debug:        .asciiz "This is a debug message trace.\n"
N_Value:      .asciiz "\nThe n value is: "

#program code is contained below under .text
                        .text
                        .globl    main      #define a global function main

############################################################################
# Procedure/Function function1
# Description: recursively calls itself until condition is met
# parameters: $a1 = n value
# return value: $v0 = computed value
# registers to be used: #s0 = num, $v1 = working solutionm $t1,$t2,$t3 = temp variables
############################################################################
function1:
            addi        $sp, $sp -16        # move the stack pointer
            sw          $ra, 0($sp)         # store register address in memory
            sw          $a1, 4($sp)         # store changing n value   
            sw          $v1, 8($sp)         # store working solution
            sw          $s0, 12($sp)        # store static n value
            
            ble		    $a1, 3, function1End# if $t0 <= $t1 then target.
            move        $s0, $a1            # Store num value in $s0

            addi	    $a1, $a1, -1	    # $a1 = num - 1

            jal		    function1		    # jump to target and save position to $ra
                
            move        $t1, $v0            # store result of function1(n-1) in $t1
            
            div		    $t1, $s0			# function1(n-1)/n
            mflo	    $t1				    # $t1 = floor($t1 / $s0) 

            move        $v1, $t1            # $v1 = current solution up to this point

                                            # Begin part to the right of plus sign
            addi        $a1, $a1, -2        # $a1 = num -3

            jal		    function1		    # jump to target and save position to $ra

            move        $t2, $v0            # store result from function1(n-3) in $t2
            mult	    $t2, $s0	        # 2 * s01 = Hi and Lo registers
            mflo	    $t2                 # copy Lo to $t2


            sll         $t3, $s0, 2         # $t3 = num * 4

            add         $v0, $v1, $t2       # result = first part of solution + second part of solution
            add         $v0, $v0, $t3       # result = result + $t3

            lw          $ra, 0($sp)         # load return address
            lw          $a1, 4($sp)         # load working num
            lw          $v1, 8($sp)         # load working solution
            lw          $s0, 12($sp)        # load static num
            addi        $sp, $sp, 16        # move stack pointer

            jr		    $ra					# jump to $ra
            

function1End:

            addi        $t0, $zero, 5       # Initialize $t0 to 5
            mult	    $a1, $t0			# $a1 * 5 = Hi and Lo registers
            mflo	    $t0					# copy Lo to $t0
            addi        $t2, $t0, 14        # add 14 to answer

            move        $v0, $t2            # result = (num * 5) + 14

            lw          $ra, 0($sp)         # load return address
            lw          $a1, 4($sp)         # load working num
            lw          $v1, 8($sp)         # load working solution
            lw          $s0, 12($sp)        # load static num
            addi        $sp, $sp, 16        # move stack pointer           

            jr		    $ra					# jump to $ra

############################################################################
# Procedure/Function main
# Description: Asks for user input, calls function1, prints result
# parameters: $a0 = n value
# return value: $v0 = computed value
# registers to be used: $a0,$a1,$s0 will be used.
############################################################################
main:
                                            # message 1
            la          $a0, message1       # $a0 = address of message1
            li          $v0, 4              # $v0 = 4  --- this is to call print_string()
            syscall                         # call print_string() to say 'num1 is : '

            li          $v0, 5              # call read_int
            syscall                         # execute call
            move        $a1, $v0

            addi        $sp, $sp -4         # move the stack pointer
            sw          $ra, 0($sp)         # store register content in memory

            jal         function1           # Call function1

            lw          $ra, 0($sp)         # load return address
            addi        $sp, $sp, 4         # move stack pointer

            move        $s0, $v0            # Copy solution to $s0

                                            # message 2
            la          $a0, message2       # $a0 = address of message2
            li          $v0, 4              # this is to call print_string()
            syscall                         # call print_string()

            move        $a0, $s0            # copy value for print_int
            li          $v0, 1              # print_int
            syscall                         # execute call

            jr          $ra                 # return