main:
  addi t0, zero, 0
  addi t1, zero, 0
  addi t2, zero, 100
  
for:
  bge t1, t2, fim
  add t0, t0, t1
  addi t1, t1, 1
  j for
  
fim:
  jr ra
  
