LI R1 0x3 ;1+2+3
LI R2 0x1
LI R3 0x0
LI R4 0x1
loop_begin:
SUBU R1 R2 R1
ADDU R3 R4 R3
ADDIU R4 0x1
BNEZ R1 loop_begin
NOP
NOP
NOP
NOP