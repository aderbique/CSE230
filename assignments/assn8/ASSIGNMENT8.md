# Assignment 8
### Fall 2020: CSE230 Computer Organization
### Author: Austin Derbique

## Disclaimer
The following text shall not be used for the purposes of academic dishonesty. It is granted only for educational & archival purposes, not to be used by other students enrolled in an artificial intelligence class. This information is not guaranteed to be correct.

# Exercises 

## Exercise 1 (2pts)
### Prompt
Perform a multiplication of two binary numbers (multiplicand 0110 and multiplier 0110) by creating a table to show steps taken, multiplicand register value, multiplier register value, and product register value for each iteration by following the steps described in the following document. (Points will be deducted if steps are not shown.)  
[Read this steps](docs/hw8mult.pdf)  
You can use this table to start [hw8_1.pdf](docs/hw8_1.pdf)

### Response

The multiplication of `0110 base 2 * 0110 base 2`, also known as `6 base 10 * 6 base 10` can be illustrated in the following steps

|Iteration|Step|Multiplicant Register Value|Multiplier Register Value|Product Register Value|
|---------|----|---------------------------|-------------------------|----------------------|
|0|Initial Values|0110|0110|0|
|1|1a Prod=Prod+multiplicand, 2=sll by 1, 3=srl by 1|01100|011|0+01100=01100|
|2|1a Prod=Prod+multiplicand, 2=sll by 1, 3=srl by 1|011000|01|01100+011000=100100|
|3|1a Prod=Prod+multiplicand, 2=sll by 1, 3=srl by 1|0110000|0|100100|
|4|2=sll by 1, 3=srl by 1|01100000|-|100100|

The final answer is: `00100100 base 2`, or `36 base 10`.

## Exercise 2 (2pts)
### Prompt
Perform a division of two binary numbers (divide 0011 0110 by 0110) by creating a table to show steps taken, quotient register value, divisor register value, and remainder register value for each iteration by following the steps described in the following document. (Points will be deducted if steps are now shown.)  
[Read these steps](docs/hw8div.pdf)  
You can use this table to start: [hw8_2.pdf](docs/hw8_2.pdf)

### Response
The division of `0011 0110 base 2 / 0110 base 2`, also known as `54 base 10 / 6 base 10` can be illustrated in the following steps:
|Iteration|Step|Quotient|Divisor|Remainder|
|0|Initial Value|0000|01100000|00110110|
|1|1: Rem-=Div,2b: R<0 Rem+=Div, sll Q, Q0=0, 3: srl Div|0000|00110000|00110110|
|2|1: Rem-=Div,2a: R>=0 sll Q, Q0=1,3: srl Div|0001|00011000|00000110|
|3|1: Rem-=Div,2b: R<0 Rem+=Div, sll Q, Q0=0|0010|00001100|00000110|
|4|1: Rem-=Div,2b: R<0 Rem+=Div, sll Q, Q0=0|0100|00000110|00000110|
|5|1: Rem-=Div,2a: R>=0 skk Q, Q0=1,3: srl Div|1001|00000000|00000000|

The final answer is `00001001 base 2`, or `9 base 10`.

## Exercise 3 (2pts)
### Prompt
Convert -4563 base 10 into a 32-bit two's complement binary number.

### Response

## Exercise 4 (2pts)
### Prompt
What decimal number does this two's complement binary number represent: `1111 1111 1111 1111 1111 0011 1000 0011` base 2?

### Reponse

## Exercise 5 (2pts)
### Prompt
What would the number `18653.4140625` base ten be in IEEE 754 single precision floating point format? You need to follow the following steps:
1. Write the above number in binary. (before normalizing it)
2. Write the above number in the normalized format.
3. Compute the biased exponent, and write it in binary.
4. Write its IEEE 754 single precision floating point format in binary, then in hex. (using 8 hex numbers)

### Response

## Exercise 6 (2pts)
### Prompt
What would the number `-18472.40625` base ten be in IEEE 754 single precision floating point format?
1. Write the above number in binary. (before normalizing it)  
2. Write the above number in the normalized format.   
3. Compute the biased exponent, and write it in binary. 
4. Write its IEEE 754 single precision floating point format in binary, then in hex. (using 8 hex numbers)

### Repsonse

## Exercise 7 (2pts)
### Prompt
What decimal number would be the IEEE 754 single precision floating point number `0xC5A3B760` be? Write your final answer in scientific notation as `m x 10^p` where `p` is an integer.

### Response

## Exercise 8 (2pts)
### Prompt
For this problem, assume 5 bits precision. Add two binary numbers, `1.0011 base two x 2^(-8)` and `1.0101 base two x 2^(-6)` showing the following steps:
1. The significand of the number with the lesser exponent is shifted right to match the exponent of the larger number.
2. Add the significands. (You can assume that you can carry all digits)
3. Normalize the sum and check for an overflow or an underflow.
4. Truncate the sum (using 5 bits precision.)

### Reponse

## Exercise 9 (2pts)
### Prompt
For this problem, assume 5 bits precision. Multiply binary two binary numbers, `1.0011 base two x 2^(-8)` and `1.0101 base two x 2^(-6)` showing the following steps:
1. Adding the exponent without bias.
2. Multiply the significands. (You can assume that you can carry all digits)
3. Normalize the product and check for an overflow or an underflow.
4. Truncate the product (using 5 bits precision.) 

## Exercise 10 (2pts)
### Prompt
Add `8.96 base ten x 10^10` to `6.78 base ten x 10^8`, assuming the following two different ways:
1. You have only three significant digits, first with guard (2 digits) and round digits.
2. You have only three significant digits without guard and rounding.

### Reponse

