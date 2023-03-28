

main:
  addi t1, zero, 5
  add t2, zero, zero
  addi t0, zero, 5
  addi t2, t2, 7
  beq t1, t0, fim
  addi t2, t2, 8
fim:
  jr ra

