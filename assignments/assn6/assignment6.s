###########################################################
#  Assignment #: 6
#  Name: Austin Derbique
#  ASU email: aderbiqu@asu.edu
#  Course: CSE/EEE230, TH 6-7:15pm
#  Description: MIPS assembly language program that defines main, readArray, printArray, and changeArrayContent procedures/functions.
# The readArray takes an array of integers as its parameter, asks a user how many numbers will  be entered, then reads in integers from a user to fill the array.
# The printArray takes an array of integers as its parameter, prints each integer of the array.
# The changeArrayContent procedure/function takes parameters of arrays of integers,  an integer that specify how many integers were entered by a user, a maximum array size, and also asks a user to enter an integer. Then it goes through each element of the array, and check if it is divisible by the entered integer, it multiplies it by the entered integer. Then it calls printArray to print out the changed content. 
# The main procedure/function calls readArray function to populate the array, calls printArray to print out its original content, then it asks a user to enter how many times the operation should be repeated, then calls changeArrayContent to change it content,
###########################################################

#data declarations: declare variable names used in program, storage allocated in RAM
                            .data 
arraySize:      .word 12
howMany:        .word 0
numbers:        .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

prompt1:        .asciiz "Specify how many numbers should be stored in the array (at most 11):\n"
prompt2:        .asciiz "Enter an integer:\n"
prompt3:        .asciiz "Enter another integer:\n"
prompt4:        .asciiz "Original Array Content:"
prompt5:        .asciiz "\n"
prompt6:        .asciiz "Result Array Content:\n"
prompt7:        .asciiz "Specify how many times to repeat:\n"

Debug:          .asciiz "This is a debug message trace.\n"

                                                    #program code is contained below under .text
                        .text
                        .globl    main              #define a global function main

			            # Exit
           


############################################################################
# Procedure/Function readArray
# Description: Read in an array of numbers
# parameters: $a0 = address of array , $a1 = arraySize , $a2 = length
# return value: $v0 = length
# registers to be used: $t0 = count, $t1 = num, $t2 = offset, $s1 = numbers, $s2 = arraySize
############################################################################
readArray:

            lw          $ra, 0($sp)                 # load arguments from stack pointer

            lw          $s1, 0($sp)                 # load $s1 = numbers
            lw          $s2, 4($sp)                 # load $s2 = arraySize

            addi        $sp, $sp, 4                 # move stack pointer 

            la          $a0, prompt1                # $a0 = address of prompt1
            li          $v0, 4                      # call print_string
            syscall                                 # execute call

                                                    # User input num1
            li          $v0, 5                      # call read_int
            syscall                                 # execute call
            move        $a2, $v0

            sw          $v0, 8($sp)                 # store length in $a3

            sll         $t2, $a2, 2                 # multiply length by four, give offset
            sub         $s1, $s1, $t2               # Subtract offset from numbers[]

            jal readArrayLoop

endReadArrayLoop:            

            move        $a0, $s1                     # Copy numbers back into argument register

            la          $a0, Debug                  # $a0 = address of prompt1
            li          $v0, 4                      # call print_string
            syscall                                 # execute call

            jr		    $ra					        # return
            

readArrayLoop:
                                                    # Begin For Loop      
            bge         $t0, $a1, endReadArrayLoop               # Branch to End if count >= arraySize
            bge         $t0, $a2, endReadArrayLoop               # Branch to End if count >= length

            la          $a0, prompt2                # $a0 = address of prompt2
            li          $v0, 4                      # call print_string
            syscall                                 # execute call

                                                    # User input num1
            li          $v0, 5                      # call read_int
            syscall                                 # execute call
            sw          $v0, 0($s1)                 # numbers[count] = $t0 (user input)

            addi        $a0, $a0, 4                 # Increment address to for next array element
            addi        $t0, $t0, 1                 # count = count + 1

            j readArrayLoop                         # Enter readArrayLoop


############################################################################
# Procedure/Function printArray
# Description: -----
# parameters: $a0 = address of array , $a1 = size
# return value: $v0 = length
# registers to be used: $t0 = count
############################################################################
printArray:

            move        $t0, $zero                  # Initialize $t0 to zero

            lw          $ra, 0($sp)                 # load arguments from stack pointer
            lw          $s1, 0($sp)                 # load $s1 = numbers
            lw          $s2, 4($sp)                 # load $s2 = arraySize
            lw          $s3, 8($sp)                 # load $s3 = length

            addi        $sp, $sp, 12                # move stack pointer   

            j printArrayLoop                        # Enter printArrayLoop
                    


printArrayLoop:
            bge         $t0, $s2 exitprintArrayLoop # Branch to exitPrintArrayLoop if count >= arraySize
            bge         $t0, $s2 exitprintArrayLoop # Branch to exitPrintArrayLoop if count >= length
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
            j printArrayLoop                        # Call printArray again

exitprintArrayLoop:
            jr          $ra                         # return

############################################################################
# Procedure/Function readArray
# Description: -----
# parameters: $a0 = address of array , $a1 = size
# return value: $v0 = length
# registers to be used: $s3 and $s4 will be used.
############################################################################
#changeArrayContent:


############################################################################
# Procedure/Function: main
# Description: program entry point
# parameters: $a0 = address of array , $a1 = arraySize
# return value: $v0 = length
# registers to be used: $s3 and $s4 will be used.
############################################################################
main:
                                                    # variables
                                                    # $s1 = length
                                                    # $s2 = howMany

            la          $a0, numbers                # $a0 = numbers[]
            la          $a1, arraySize              # $a1 = arraySize = 12

            addi        $sp, $sp -4                 # Move stack pointer prior to SW
            sw          $ra, 0($sp)                 # Save variables into memory
            jal readArray                           # Call readArray

                                                    # Print Original Array Content Message
            la          $a0, prompt4                # $a0 = address of prompt4
            li          $v0, 4                      # call print_string
            syscall                                 # execute call


            addi        $sp, $sp -12                # Move stack pointer prior to SW
            sw          $ra, 0($sp)                 # Save variables into memory                                                    
            jal printArray                          # Call printArray

                                                    # Print Repeat Times Message
            la          $a0, prompt7                # $a0 = address of prompt7
            li          $v0, 4                      # call print_string
            syscall                                 # execute call

                                                    # User input num3
#            li          $v0, 5                      # call read_int
#            syscall                                 # execute call
#            move        $s3, $v0
                                                    # Call loopChangeArrayContent

            jr		$ra		