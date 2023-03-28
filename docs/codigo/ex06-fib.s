fib:
  addi sp, sp, -8
  sw   ra, 0(sp)
  sw   s0, 4(sp)
  
  # Verifica casos base
  beq  a0, zero, Fim
  addi t0, zero, 1
  beq  a0, t0, Fim
  
  addi a0, a0, -1
  addi s0, a0, -1
  call fib
  
  # troca a0 e s0
  add  t0, a0, zero
  add  a0, s0, zero
  add  s0, t0, zero
  
  call fib  
  
  add  a0, a0, s0
  
Fim:
  sw   s0, 4(sp)
  sw   ra, 0(sp)
  addi sp, sp, 8
  
  ret

  
  
  
