int strlen(const char *str)

  addi t0, zero, 0
loop:
  lbu t1, 0(a0)
  beq t1, zero, fim
  addi t0, t0, 1
  addi a0, a0, 1
  j loop
  
fim:
  add a0, t0, zero
  ret



char *strcpy(char *destination, const char *source)

  addi t0, a0, 0
loop:
  lbu t1, 0(a1)
  sbu t1, 0(a0)
  bne t1, zero, loop
  
  add a0, t0, zero
  ret
  


int strcmp(const char *str1, const char *str2)

loop:
  lbu t0, 0(a0)
  lbu t1, 0(a1)
  sub t2, t0, t1
  bne t2, zero, fim
  bne t0, zero, loop
  
fim:
  add a0, t2, zero
  ret


char *strcat(char *destination, const char *source)

  addi sp, sp, -8
  sw ra, 0(sp)
  sw s0, 4(sp)

  add s0, a0, zero
  lbu t0, 0(a0)
loop:
  beq t0, zero, copia
  addi a0, a0, 1
  lbu t0, 0(a0)
  j loop
  
copia:
  call strcpy
  add a0, s0, zero
  
  lw s0, 4(sp)
  lw ra, 0(sp)
  addi sp, sp, 8
  
  ret
  
   


