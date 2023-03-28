# Retorna o menor de dois numeros entre a0 e a1, no registrador a0  
Menor:
  blt a0, a1, fim
  add a0, zero, a1
fim:
  ret

main:
  addi sp, sp, -4
  sw   ra, 0(sp)

  addi a0, zero, 10
  addi a1, zero, 7
  call Menor
  addi a0, zero, 8
  addi a1, zero, 15
  call Menor
  
  lw   ra, 0(sp)
  addi sp, sp, 4
  ret
  
 
