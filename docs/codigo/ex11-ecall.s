.section .data
STR1:
 .word 0x20616944
 .word 0x50206564
 .word 0x41564f52
 .word 0x00000000
 
STR2:
 .word 0x3034434d
 .word 0x6e552034
 .word 0x6d616369
 .word 0x00000070
 
STR3:
 .word 0x6150204f
 .word 0x50206f74
 .word 0x74657461
 .word 0x00000061
 
.section .text
main:
  addi sp, sp, -4
  sw   ra, sp, 0
    
  lui a0, %hi(STR1)
  addi a0, a0, %lo(STR1)
  addi a1, zero, 12
  addi t0, zero, 3
  ecall
  
  addi a0, zero, 13
  addi t0, zero, 2
  ecall
  
  lui a0, %hi(STR2)
  addi a0, a0, %lo(STR2)
  addi a1, zero, 13
  addi t0, zero, 3
  ecall
  
  addi a0, zero, 13
  addi t0, zero, 2
  ecall

  lui a0, %hi(STR3)
  addi a0, a0, %lo(STR3)
  addi a1, zero, 13
  addi t0, zero, 3
  ecall
  
  addi a0, zero, 13
  addi t0, zero, 2
  ecall

  lw ra, sp, 0
  addi sp, sp, 4
  ret
  
Minuscula:
  addi t0, zero, 65
  blt  a0, t0, finalMinuscula
  addi t0, zero, 91
  bgt  a0, t0, finalMinuscula
  addi a0, a0, 32
finalMinuscula:
  ret
  
   
