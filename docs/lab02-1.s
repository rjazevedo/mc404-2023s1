main:
  addi t0, zero, 4
  ecall    
  addi a0, a0, -10 
  addi t0, zero, 1
  ecall 
  ret
