###########################################################
# Assignment #: 4
#  Name: Austin Derbique
#  ASU email: aderbiqu@asu.edu
#  Course: CSE/EEE230, TH 6-7:15pm
#  Description: MIPS assembly language program that reads a customer's current and previous meter readings of electricity and a month to compute its electricity bill.
###########################################################

#data declarations: declare variable names used in program, storage allocated in RAM
                            .data  
prompt1:        .asciiz "Please enter the new electricity meter reading:\n"
prompt2:        .asciiz "Please enter the old electricity meter reading:\n"
prompt3:        .asciiz "Please enter a month to compute their electricity bill,\n"
prompt4:        .asciiz "Use an integer between 1 and 12 (1 for January, etc.):\n"

Debug:          .asciiz "This is a debug message trace.\n"

BillResultPart1:    .asciiz "Your total bill amount for this month: "
BillResultPart2:    .asciiz " dollar(s) for "
BillResultPart3:    .asciiz " KWH\n"

BillResultNone:     .asciiz "No bill to pay this month.\n"


#program code is contained below under .text
                        .text
                        .globl    main    #define a global function main

# the program begins execution at main()
main:

            # $t1 = newMeter
            # $t2 = oldMeter
            # $t3 = month 
            # $t4 = KWHforMonth
            # $t5 = billAmount                             
                                        # Print prompt 1
            la          $a0, prompt1    # $a0 = address of prompt1
            li          $v0, 4          # call print_string
            syscall                     # execute call

                                        # User input num1
            li          $v0, 5          # call read_int
            syscall                     # execute call
            move $t1, $v0   
                                        # Print prompt 2
            la          $a0, prompt2    # $a0 = address of prompt2
            li          $v0, 4          # call print_string
            syscall                     # execute call

                                        # User input num2
            li          $v0, 5          # call read_int
            syscall                     # execute call
            move $t2, $v0     
               
                                        # Print prompt 3
            la          $a0, prompt3    # $a0 = address of prompt3
            li          $v0, 4          # call print_string
            syscall                     # execute call

                                        # Print prompt 4
            la          $a0, prompt4    # $a0 = address of prompt4
            li          $v0, 4          # call print_string
            syscall                     # execute call

                                        # User input num3
            li          $v0, 5          # call read_int
            syscall                     # execute call
            move $t3, $v0            
                                        # Finish Gathering Inputs
                                        # Begin Calculations

            sub         $t4, $t1, $t2               # KWHforMonth = newMeter - OldMeter

            sle         $t0, $t4, $zero                 # Set $t0 to 1 if KWHforMonth is less than or equal to zero
            bne         $t0, $zero, NoUsage         # Jump to NoUsage if $t0 is not zero


                                                    # Start Calculating Bill amount
            addi        $t5, $t4, -250              # bill amount = KWHforMonth - 250
            

            addi        $t0, $zero, 250             # Set $t0 = 250
            sle         $t0, $t4, $t0               # If $t4 <= 250,  $t0 = 1, otherwise $t0 = 0 
            bne         $t0, $zero, LowUsage        # If KWHforMonth is <= 250, then jump to Low Usage
                                                    # else proceed with HighUsage

            #add        $t0, $zero, $zero
            #addi        $t0, $zero, 9              # Set $t0 = 9
                                                    # Check if 6 <= month >= 9
            #sle         $t0, $t3, $t0              # $t0 = 1 if <= 9, else 0
            #beq         $t0, $zero, HighUsageElse  # Jump to HighUsageElse if $t0 = 0; meaning $t3 > 9
            
            blt        $t3, 6, HighUsageElse        # branch on less than or equal to 6
            bgt        $t3, 9, HighUsageElse        # branch on grather than 9

            #add        $t0, $zero, $zero
            #addi        $t0, $zero, 6               # Set $t0 = 6
            #slt         $t0, $t3, $t0               # Check if 1 <= month < 6, else 0
            #bne         $t0, $zero, HighUsageElse   # Jump to HighUsageElse if $t0 != 1; meaning $t3 < 6

                                                    # Proceed with HighUsageMidYear

            div         $t5, $t5, 18                # Bill amount = Bill Amount / 18
            addi        $t5, $t5, 25                # Bill amount = Bill Amount + 25
            j PrintMessages                         # Jump to PrintMessages

LowUsage:
            addi        $t5, $zero, 25  # Set billAmount = 25 
            j PrintMessages

HighUsageElse:

            div         $t5, $t5, 20                # Bill amount = Bill Amount / 20
            addi        $t5, $t5, 25                # Bill amount = Bill Amount + 25
            j PrintMessages
                    

NoUsage:                                        # Executed if KWH usage is zero or less
                                                # Print prompt 6
            la          $a0, BillResultNone     # $a0 = address of BillResultNone
            li          $v0, 4                  # call print_string
            syscall                             # execute call  
            j Exit

PrintMessages:

            la          $a0, BillResultPart1   # $a0 = address of BillResultPart1
            li          $v0, 4          # call print_string
            syscall  

            move        $a0, $t5       # Copy Bill amount into $a0
            li          $v0, 1          # prepare to call print_int
            syscall                     # call print_int()      

            la          $a0, BillResultPart2   # $a0 = address of BillResultPart2
            li          $v0, 4          # call print_string
            syscall  

            move        $a0, $t4        # Copy KWHforMonth amount into $a0
            li          $v0, 1          # prepare to call print_int
            syscall                     # call print_int()  

            la          $a0, BillResultPart3   # $a0 = address of BillResultPart2
            li          $v0, 4          # call print_string
            syscall               

Exit:
            jr          $ra             # return