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
    
.section .rodata
INICIO:
  .word 15  
  
.section .text

main:
  lui  a0, %hi(INICIO)
  addi a0, a0, %lo(INICIO)
  lw   t0, 0(a0)
  lui  a0, %hi(VETOR)
  addi a0, a0, %lo(VETOR)
  
  addi t1, zero, 25
for:
  sw   t0, 0(a0)
  addi t0, t0, 1
  addi a0, a0, 4
  addi t1, t1, -1
  bne  t1, zero, for
  
  ret
  
