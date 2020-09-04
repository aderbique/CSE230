###########################################################
# Assignment #: 3
#  Name: Austin Derbique
#  ASU email: aderbiqu@asu.edu
#  Course: CSE/EEE230, TH 6-7:15pm
#  Description: MIPS assembly language program that performs arithmetic and logical operations on variables.
###########################################################

#data declarations: declare variable names used in program, storage allocated in RAM
                            .data  
prompt1:      .asciiz "Enter a value: \n"
prompt2:      .asciiz "\nEnter another value:\n"
prompt3:      .asciiz "\nEnter one more value: \n"

message1:     .asciiz "\nnum4+num1="
message2:     .asciiz "\nnum1-num2="
message3:     .asciiz "\nnum4*num2="
message4:     .asciiz "\nnum1/num3="
message5:     .asciiz "\nnum3 mod num1="
message6:     .asciiz "\n((((num2 mod 4) + num3) * 2) / num4) + num1="

#program code is contained below under .text
                        .text
                        .globl    main    #define a global function main

# the program begins execution at main()
main:

            # $t1 = num1
            # $t2 = num2
            # $t3 = num3
            # $t4 = num4                                    
                                        # Print prompt 1
            la          $a0, prompt1    # $a0 = address of prompt1
            li          $v0, 4          # call print_string
            syscall                     # execute call

                                        # User input num1
            li          $v0, 5          # call read_int
            syscall                     # execute call
            move $t1, $v0   

            move        $a0, $t1        # copy value for print_int
            li          $v0, 1          # print_int
            syscall                     # execute call


                                        # Print prompt 2
            la          $a0, prompt2    # $a0 = address of prompt2
            li          $v0, 4          # call print_string
            syscall                     # execute call

                                        # User input num2
            li          $v0, 5          # call read_int
            syscall                     # execute call
            move $t2, $v0     
            
            move        $a0, $t2        # copy value for print_int
            li          $v0, 1          # print_int
            syscall                     # execute call                   

                                        # Print prompt 3
            la          $a0, prompt3    # $a0 = address of prompt3
            li          $v0, 4          # call print_string
            syscall                     # execute call

                                        # User input num3
            li          $v0, 5          # call read_int
            syscall                     # execute call
            move $t3, $v0            
            
            move        $a0, $t3        # copy value for print_int
            li          $v0, 1          # print_int
            syscall                     # execute call

                                        # Print prompt 3
            la          $a0, prompt3    # $a0 = address of prompt3
            li          $v0, 4          # call print_string
            syscall                     # execute call

                                        # User input num4
            li          $v0, 5          # call read_int
            syscall                     # execute call
            move $t4, $v0
            
            move        $a0, $t4        # copy value for print_int
            li          $v0, 1          # print_int
            syscall                     # execute call

                                        # Print message 1
            la          $a0, message1   # $a0 = address of message1
            li          $v0, 4          # call print_string
            syscall                     # execute call

                                        # num4 + num1
            add         $a0, $t4, $t1   # $a0 = $t4 + $t1
            li          $v0, 1          # prepare to call print_int()
            syscall                     # call print_int()    

                                        # Print message 2
            la          $a0, message2   # $a0 = address of message2
            li          $v0, 4          # call print_string
            syscall                     # execute call

            sub         $a0, $t1, $t2   # $a0 = num1 - num2
            li          $v0, 1          # prepare to call print_int
            syscall                     # call print_int()     

                                        # Print message 3
            la          $a0, message3   # $a0 = address of message3
            li          $v0, 4          # call print_string
            syscall                     # execute call

            mult        $t4, $t2        # multiply num4 * num2
            mflo        $a0             # store value in $a0
            li          $v0, 1          # call print_int
            syscall                     # execute call

                                        # Print message 4
            la          $a0, message4   # $a0 = address of message4
            li          $v0, 4          # call print_string
            syscall                     # execute call            

            div         $a0, $t1, $t3   # $a0 = num1 / num3
            li          $v0, 1          # call print_int
            syscall                     # execute call

                                        # Print message 5
            la          $a0, message5   # $a0 = address of message5
            li          $v0, 4          # call print_string
            syscall                     # execute call

            div         $s0, $t3, $t1   # $s0 = num3 / num1
            mfhi        $a0
            li          $v0, 1          # call int
            syscall                     # execute call            

                                        # Print message 6
            la          $a0, message6   # $a0 = address of message6
            li          $v0, 4          # call print_string
            syscall                     # execute call    

            div         $s0, $t2, 4   # $s0 = num2 / 4
            mfhi        $a0             # result = num2 mod 4
            add         $s1, $a0, $t3   # result = result + num3
            sll         $s1, $s1, 1     # result = result * 2
            div         $s0, $s1, $t4   # result = result / num4
            add         $a0, $s0, $t1   # result = result + num1

            li          $v0, 1          # call int
            syscall                     # execute call                       

            jr          $ra             # return