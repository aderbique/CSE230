###########################################################
# Assignment #: 5
#  Name: Austin Derbique
#  ASU email: aderbiqu@asu.edu
#  Course: CSE/EEE230, TH 6-7:15pm
#  Description: MIPS assembly language program that perform decision making using branch instructions and creates loops.
###########################################################

#data declarations: declare variable names used in program, storage allocated in RAM
                            .data 
numbers_len:    .word     11
numbers:        .word     2, 19, 23, -7, 15, -17, 11, -4, 23, -26, 27

prompt1:        .asciiz "Enter an ending index:\n"
prompt2:        .asciiz "Enter an integer:\n"
prompt3:        .asciiz "Enter another integer:\n"
prompt4:        .asciiz "Result Array Content:"
prompt5:        .asciiz "\n"

Debug:          .asciiz "This is a debug message trace.\n"

                                                    #program code is contained below under .text
                        .text
                        .globl    main              #define a global function main

                                                    # the program begins execution at main()
main:

                                                    # $s1 = endingIndex
                                                    # $s2 = num1
                                                    # $s3 = num2
                                                    # $s4 = numbers_len
                                                    # $s5 = numbers
                                                    # $t0 = count
                                                    # $t1 = tmp1
                                                    # $t2 = tmp2
                                                    # $t3 = offsetCount

                                                    # Print prompt 1
            la          $a0, prompt1                # $a0 = address of prompt1
            li          $v0, 4                      # call print_string
            syscall                                 # execute call

                                                    # User input num1
            li          $v0, 5                      # call read_int
            syscall                                 # execute call
            move        $s1, $v0   
                                                    # Print prompt 2
            la          $a0, prompt2                # $a0 = address of prompt2
            li          $v0, 4                      # call print_string
            syscall                                 # execute call

                                                    # User input num2
            li          $v0, 5                      # call read_int
            syscall                                 # execute call
            move        $s2, $v0     
               
                                                    # Print prompt 3
            la          $a0, prompt3                # $a0 = address of prompt3
            li          $v0, 4                      # call print_string
            syscall                                 # execute call

                                                    # User input num3
            li          $v0, 5                      # call read_int
            syscall                                 # execute call
            move        $s3, $v0            
                                                    # Finish Gathering Inputs
                                                    # Begin Logic

            la          $a0, numbers_len            # $a0 = address of numbers_len
            lw          $s4, 0($a0)                 # load in word numbers_len


            la          $s5, numbers                # $a0 = address of numbers
            move        $t1, $zero                  # Initialize $t1 to zero
            bgt         $s2, $s3, SwitchNums        # branch if num1 > num2
            j Loop

SwitchNums:                                         # swap num 2 with num 1
            move $t1, $s2                           # $t1 = $s2
            move $s2, $s3                           # $s2 = $s3
            move $s3, $t1                           # $s3 = $t1
            j Loop

Loop:      
                                                    # Begin For Loop      
            bge         $t0, $s1, End               # Branch to End if count >= endingIndex
            bge         $t0, $s4, End               # Branch to End if count >= numbers_len

            lw          $t1, 0($s5)                 # $t1 = numbers[count];
            ble         $t1, $s2, DoNothing         # Branch if condition numbers[count] > num1 not met
            bge         $t1, $s3, DoNothing         # Branch if condition numbers[count] < num2 not met
                                                    # Proceed to perform multiplication and addition
            mult        $t1, $s2                    # Multiply numbers[count] * num1
            mflo        $a0                         
            add         $t2, $a0, $s3               # $t2 = $a0 + $s3; tmp2 = tmp2 + num2

            sw          $t2, 0($s5)                 # numbers[count] = numbers[count]*num1 + num2;

            addi        $t3, $t3, 4                 # add to offset count
            addi        $s5, $s5, 4                 # Increment address space by 4 bytes
            addi        $t0, $t0, 1                 # count = count = 1
            j Loop                                  # Call Loop again

DoNothing:                                          # Skips multiplication, leaves values in array alone.
            addi        $t3, $t3, 4                 # add to offset count
            addi        $s5, $s5, 4                 # Increment address space by 4 bytes
            addi        $t0, $t0, 1                 # count = count = 1
            j Loop                                  # Call Loop again


 
End:
                                                    # Print prompt 4
            la          $a0, prompt4                # $a0 = address of prompt4
            li          $v0, 4                      # call print_string
            syscall                                 # execute call
            move $t0, $zero                         # Initialize count to zero
            move $t1, $zero                         # Initialize temp1 to zero
            addi        $a0, $zero, -1              # set to -1
            mult        $t3, $a0                    # multiply offset by -1
            mflo        $a0                         # take integer value
            add        $s5, $s5, $a0                # Reset back to start of memory
            j PrintLoop


PrintLoop:
            bge         $t0, $s4 Exit               # Branch to Exit if count >= numbers_len
            lw          $t1, 0($s5)                 # $t1 = numbers[count];
            addi        $s5, $s5, 4                 # Increment address space by 4 bytes

                                                    # Prompt 4        
            la          $a0, prompt5                # $a0 = address of prompt5
            li          $v0, 4                      # this is to call print_string()
            syscall                                 # call print_string()

                                                    # print numbers[count]
            move        $a0, $t1                    # $a0 = tmp1
            li          $v0, 1                      # prepare to call print_int()
            syscall                                 # call print_int()

            addi        $t0, $t0, 1                 # count = count = 1
            j PrintLoop                             # Call PrintLoop again

Exit:
            jr          $ra                         # return