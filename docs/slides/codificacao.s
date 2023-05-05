mul t0, t1, t2
l:
addi s0, s1, 20 # 01 44 84 13
sub a0, a1, a2  # 40 c5 85 33
beq s0, s1, l  # fe 94 08 e3 end. 0x0034
lw a0, 0(s0)    # 00 00 01 0a
sw a0, 0(s0)    # 00 a4 20 23
