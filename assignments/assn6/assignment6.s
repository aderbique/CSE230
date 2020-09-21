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
prompt4:        .asciiz "Original Array Content:\n"
prompt5:        .asciiz "\n"
prompt6:        .asciiz "Result Array Content:\n"
prompt7:        .asciiz "Specify how many times to repeat:\n"

Debug:          .asciiz "This is a debug message trace.\n"

                                                    #program code is contained below under .text
                        .text
                        .globl    main              #define a global function main
           
############################################################################
# Procedure/Function: main
# Description: program entry point
# parameters: $a0 = address of array , $a1 = arraySize, $a2 = length, $a3 = offset
# registers to be used: $s1-$s7, $t0-$t4
############################################################################
main:

            addi        $sp, $sp -4                # move the stack pointer
            sw          $ra, 0($sp)                # store register content in memory

            jal readArray                          # Call readArray

            lw          $ra, 0($sp)
            addi        $sp, $sp, 4            


            move        $t7, $a0
                                                    # Print Original Array Content Message
            la          $a0, prompt4                # $a0 = address of prompt4
            li          $v0, 4                      # call print_string
            syscall                                 # execute call

            move        $a0, $t7
     
            addi        $sp, $sp -4              # Move stack pointer prior to SW
            sw          $ra, 0($sp)                                                  
            jal printArray                          # Call printArray
            lw          $ra, 0($sp)
            addi        $sp, $sp, 4

            move        $t7, $a0
                                                    # Print Repeat Times Message
            la          $a0, prompt7                # $a0 = address of prompt7
            li          $v0, 4                      # call print_string
            syscall                                 # execute call
                                                    # User input num3 how many times to repeat
            li          $v0, 5                      # call read_int
            syscall                                 # execute call
            move        $s6, $v0                    # $s6 = howMany
            
            move        $a0, $t7                    # set $a0 back to what it was
            addi        $t0, $zero, 0                 # Initialize $t0 to zero; count = 0

loopChangeArrayContent:
            bge         $t0, $s6, endLoopChangeArrayContent #Branch if i >= howMany

            addi        $sp, $sp -4                # move the stack pointer
            sw          $ra, 0($sp)                # store register content in memory
            jal changeArrayContent                 # call changeArrayContent

            lw          $ra, 0($sp)
            addi        $sp, $sp, 4   
            addi        $t0, $t0, 1                 # count = count + 1

            j loopChangeArrayContent                # Call loopChangeArrayContent
                                          
endLoopChangeArrayContent:
            jr		$ra  #Exit main

############################################################################
# Procedure/Function readArray
# Description: Read in an array of numbers
# parameters: $a0 = address of array , $a1 = arraySize, $a2 = length, $a3 = offset
# return value: $v0 = numbers
# registers to be used: $t6 = count, $t1 = num, $t2 = offset, $s1 = numbers, $s2 = arraySize
############################################################################
readArray:

            la          $s1, numbers               # load address of numbers array
            la          $s2, arraySize             # load address of arraySize
            lw          $t3, 0($s2)                # load word $t3 = arraySize

            la          $a0, prompt1                # $a0 = address of prompt1
            li          $v0, 4                      # call print_string
            syscall                                 # execute call

                                                    # User input num1
            li          $v0, 5                      # call read_int
            syscall                                 # execute call
            move        $s3, $v0                    # $s3 = length

            
            sll         $t2, $s3, 2                 # multiply length by four, give offset
            sub         $s1, $s1, $t2               # Subtract offset from numbers[]

            j readArrayLoop


endReadArrayLoop:            


            sll         $t2, $s3, 2                 # multiply length by four, give offset
            sub         $s1, $s1, $t2               # Subtract offset from numbers[]

            move        $a0, $s1                    # Copy numbers back into argument register
            move        $a1, $t3                    # save arraySize
            move        $a2, $s3                    # save length
            move        $a3, $t2                    # save offset
            move        $v0, $s1                    # Return value
            jr		    $ra					        # return
            

readArrayLoop:
                                                    # Begin For Loop      
            bgt         $t6, $t3, endReadArrayLoop  # Branch to End if count >= arraySize
            bge         $t6, $s3, endReadArrayLoop  # Branch to End if count >= length

            la          $a0, prompt2                # $a0 = address of prompt2
            li          $v0, 4                      # call print_string
            syscall                                 # execute call

                                                    # User input num1
            li          $v0, 5                      # call read_int
            syscall                                 # execute call
            sw          $v0, 0($s1)                 # numbers[count] = $t0 (user input)
            addi        $s1, $s1, 4                 # Increment address to for next array element
            addi        $t6, $t6, 1                 # count = count + 1

            j readArrayLoop                         # Enter readArrayLoop


############################################################################
# Procedure/Function printArray
# Description: Prints the array
# parameters: $a0 = address of array , $a1 = arraySize, $a2 = length, $a3 = offset
# registers to be used: $t7 = count,$t2-$t4, $s1-$s2
############################################################################
printArray:

            move        $s1, $a0                    # load $s1 = address numbers[]
            
            move        $t2, $a1                    # load $s2 = address arraySize
            #lw          $t2, 0($s2)		            # load contents of $s2, arraySize
            

            move        $t3, $a2                    # load $s3 = length
            move        $t4, $a3                    # load $s4 = offset
            addi        $t7, $zero, 0
            j           printArrayLoop              # Enter printArrayLoop
                    
printArrayLoop:

            bge         $t7, $t2 exitprintArrayLoop # Branch to exitPrintArrayLoop if count > arraySize
            bge         $t7, $t3 exitprintArrayLoop # Branch to exitPrintArrayLoop if count > length

            lw          $t1, 0($s1)                 # $t1 = numbers[count];
                                                    # print numbers[count]
            move        $a0, $t1                    # $a0 = tmp1
            li          $v0, 1                      # prepare to call print_int()
            syscall                                 # call print_int()

            la          $a0, prompt5                # $a0 = address of prompt5
            li          $v0, 4                      # this is to call print_string()
            syscall                                 # call print_string()

            addi        $t7, $t7, 1                 # count = count = 1
            addi        $s1, $s1, 4                 # Increment address space by 4 bytes 

            j           printArrayLoop              # Call printArray again

exitprintArrayLoop:

            sll         $s0, $t3, 2                 # multiply length by four, give offset
            sub         $s1, $s1, $s0               # Subtract offset from numbers[]

            move        $a0, $s1                    # Copy array back into $a0
            jr          $ra                         # return

############################################################################
# Procedure/Function changeArrayContent
# Description: multiplies by input if modulo = 0
# parameters: $a0 = address of array , $a1 = arraySize, $a2 = length, $a3 = offset
# return value: $v0 = length
# registers: to be used: $s3 and $s4 will be used.
            # $s1 = numbers[]
            # $t1 = numbers[i]
            # $t2 = arraySize
            # $t3 = length
            # $t4 = num1
            # $t5 = count
############################################################################
changeArrayContent:

            move        $s1, $a0                    # load $s1 = address numbers[]
            
            move        $t2, $a1                    # load $s2 = address arraySize
            #lw          $t2, 0($s2)		            # load contents of $s2, arraySize

            move        $t3, $a2                    # load $s3 = length
            move        $t4, $a3                    # load $s4 = offset

            la          $a0, prompt2                # $a0 = address of prompt2
            li          $v0, 4                      # call print_string
            syscall                                 # execute call

                                                    # User input num1
            li          $v0, 5                      # call read_int
            syscall                                 # execute call
            move        $t4, $v0                    # $t4 = num, user input

            addi	    $t5, $zero, 0			    # $t0 = $t1 + 0
                                        

loopMultiplyNum:
            bge         $t5, $t2, exitLoopChangeArrayContent #Break if count > arraySize
            bge         $t5, $t3, exitLoopChangeArrayContent #Break if count > length

            lw          $t1, 0($s1)                 # $t1 = numbers[count];
       
                                                    # Begin Modulo Logic
            abs         $s7, $t1                    # $s7 = abs($s5) This is to ignore signs

            div         $s7, $s7, $t4               # $s5 = numbers[i] / num1
            mfhi        $a0                         # result = numbers[i] mod num1

            move        $s7, $a0
            bne		    $s7, 0, loopDoNothing	    # if numbers[i] mod num1 != 0 then branch to loopDoNothing

            mult	    $t1, $t4			        # $t0 * $t1 = Hi and Lo registers
            mflo	    $s7					        # copy Lo to $t2

            sw		    $s7, 0($s1)		            # Save numbers[i] = numbers[i] * num1 
            
            addi        $t5, $t5, 1                 # count = count = 1
            addi        $s1, $s1, 4                 # Increment address space by 4 bytes 


            j           loopMultiplyNum


loopDoNothing:
            addi        $t5, $t5, 1                 # count = count + 1
            addi        $s1, $s1, 4                 # Increment address space by 4 bytes 
            j           loopMultiplyNum

exitLoopChangeArrayContent:

            la          $a0, prompt6                # $a0 = address of prompt5
            li          $v0, 4                      # this is to call print_string() Result Array Content
            syscall                                 # call print_string()
            
            sll         $s5, $t3, 2                 # multiply length by four, give offset
            sub         $s1, $s1, $s5               # Subtract offset from numbers[]

            move        $a0, $s1                    # Move values back into argument register
            move        $a1, $s2                    # Move values back into argument register
            move        $a2, $s3                    # Move values back into argument register
            move        $a3, $s4                    # Move values back into argument register

            addi        $sp, $sp -4                 # move the stack pointer
            sw          $ra, 0($sp)                 # store register content in memory
            jal         printArray                  # Call Print Array
            lw          $ra, 0($sp)
            addi        $sp, $sp, 4  

            jr		    $ra					        # jump to $ra