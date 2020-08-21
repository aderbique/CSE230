###########################################################
# Assignment #: 1
#  Name: Austin Derbique
#  ASU email: aderbiqu@asu.edu
#  Course: CSE/EEE230, TH 6-7:15pm
#  Description: This is my first assembly language program.
###########################################################

#data declarations: declare variable names used in program, storage allocated in RAM
                            .data  
message1:         .asciiz "Hello World.\n" #create a string containing "Hello World.\n"
message2:         .asciiz "Goodbye World.\n" #create a string containing "Goodbye World.\n"
message3:         .asciiz "This is my first MIPS program.\n" #create a string containing "This is my first MIPS program.\n"

#program code is contained below under .text
                        .text
                        .globl    main    #define a global function main

# the program begins execution at main()
main:
            la          $a0, message1  # $a0 = address of message1
            li          $v0, 4                # $v0 = 4  --- this is to call print_string()
            syscall                           # call print_string()

            la		$a0, message2 # $a0 = address of message2
            li		$v0, 4		      # $v0 = 4 --- this is to call print_string()
            syscall                           # call print_string()

            la		$a0, message3 # $a0 = address of message3
            li		$v0, 4		      # $v0 = 4 --- this is to call print_string()
            syscall                           # call print_string()

            jr          $ra                   # return