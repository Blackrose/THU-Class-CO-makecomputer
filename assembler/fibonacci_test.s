LI R1 0x1
LI R2 0x1
LI R3 0x85
LI R5 0x1
SLL R3 R3 0x0
LI R4 0x32 ;循环50次
loop_begin:
SW R3 R1 0x0 ;循环开始
SW R3 R2 0x1
NOP
ADDU R1 R2 R1
ADDU R1 R2 R2
ADDIU R3 0x2
SUBU R4 R5 R4
BNEZ R4 loop_begin ;R4不为0则到循环开始处
NOP
JR r7
NOP