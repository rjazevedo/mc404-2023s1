.section .data
VETOR:
  .word 10 #
  .word 7 
  .word 15 #
  .word 4
  .word 3 #
  .word 9
  .word 6 #
  .word 16
  .word 20 #
  .word 5
  .word 2 #
  .word 10
  .word 9 #
  .word 25
  .word 14 #
  .word 12
    
.section .rodata
TAMANHO:
  .word 8  
  
.section .text

main:
  addi sp, sp, -20
  sw   ra, sp, 16
  
  lui  t0, %hi(TAMANHO)
  addi t0, t0, %lo(TAMANHO)
  lw   a1, 0(t0)
  lui  a0, %hi(VETOR)
  addi a0, a0, %lo(VETOR)
  addi a2, sp, 0
  addi a3, sp, 8
  
  call EncontraCantos
  
  lw   ra, sp, 16
  addi sp, sp, 20
  
  ret
  
# void EncontraCantos(ponto *v, int tamanho, ponto *inf_esq, ponto *sup_dir)
EncontraCantos:
  addi sp, sp, -20
  sw   ra, sp, 16
  sw   s0, sp, 12
  sw   s1, sp, 8
  sw   s2, sp, 4
  sw   s3, sp, 0
  
  add  s0, a0, zero
  add  s1, a1, zero
  add  s2, a2, zero
  add  s3, a3, zero
  
  lw   t0, s0, 0
  sw   t0, s2, 0
  sw   t0, s3, 0
  
  lw   t0, s0, 4
  sw   t0, s2, 4
  sw   t0, s3, 4
  
  addi s0, s0, 8
  addi s1, s1, -1
  
loop:
  beq  s1, zero, fim
  add  a0, s0, zero
  add  a1, s2, zero
  call AjustaInfEsq
  
  add  a0, s0, zero
  add  a1, s3, zero
  call AjustaSupDir
  
  addi s1, s1, -1
  addi s0, s0, 8
  j    loop
 
fim:
  lw   t0, s2, 0
  addi t0, t0, -1
  sw   t0, s2, 0
  lw   t0, s2, 4
  addi t0, t0, -1
  sw   t0, s2, 4
  
  lw   t0, s3, 0
  addi t0, t0, 1
  sw   t0, s3, 0
  lw   t0, s3, 4
  addi t0, t0, 1
  sw   t0, s3, 4

  lw   s3, sp, 0
  lw   s2, sp, 4
  lw   s1, sp, 8
  lw   s0, sp, 12
  lw   ra, sp, 16
  addi sp, sp, 20
  
  ret
  
# void AjustaInfEsq(ponto *p, ponto *inf_esq)
AjustaInfEsq:
  lw  t0, a0, 0
  lw  t1, a1, 0
  
  bge t0, t1, naoAltera1
  sw  t0, a1, 0
  
naoAltera1:
  lw  t0, a0, 4
  lw  t1, a1, 4
  
  bge t0, t1, naoAltera2
  sw  t0, a1, 4
  
naoAltera2:
  ret
  
# void AjustaSupDir(ponto *p, ponto *sup_dir)
AjustaSupDir:
  lw  t0, a0, 0
  lw  t1, a1, 0
  
  bge t1, t0, naoAltera3
  sw  t0, a1, 0
  
naoAltera3:
  lw  t0, a0, 4
  lw  t1, a1, 4
  
  bge t1, t0, naoAltera4
  sw  t0, a1, 4
  
naoAltera4:
  ret
  
