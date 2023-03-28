
main:
  addi t1, zero, 9
  add t2, zero, zero
  addi t0, zero, 5
  bne t1, t0, else
  
  addi t2, t2, 7
  j fim
else:
  addi t2, t2, 15
 
fim:
  jr	ra


