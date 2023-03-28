.section .data
VETOR:
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
  .word 0
    
.section .text

main:
  lui  a0, %hi(VETOR)
  addi a0, a0, %lo(VETOR)
  
  addi t0, zero, 0
  addi t1, zero, 25
for:
  sw   t0, 0(a0)
  addi t0, t0, 1
  addi a0, a0, 4
  bne  t0, t1, for
  
  ret
  
