main:
  addi t0, zero, 20
  addi t1, zero, 10
  
loop:
  beq t0, t1, fim
  addi t0, t0, 2
  addi t1, t1, 3
  j loop
  
fim:
  jr ra
