.section .rodata
CONST:
  .word 27485
  
.section .text

main:
  lui  a0, %hi(CONST)
  addi a0, a0, %lo(CONST)
  
  lw t0, 0(a0)
  
  ret
  
