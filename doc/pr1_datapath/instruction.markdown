## 指令设计
用前5位表示op。共30条。 
加*为扩展指令。XXX，YYY，ZZZ为寄存器标号。III为立即数。 

### R

	指令	编码
	MFIH	00001XXX00000000
	MFPC	00010XXX00000000
	MTIH	00011XXX00000000
	MTSP	00100XXX00000000
	AND		00101XXXYYY00000
	OR		00110XXXYYY00000
	*NOT	00111XXXYYY00000
	*SLT	01000XXXYYY00000
	CMP		01001XXXYYY00000
	SLL		01010XXXYYYIII00
	SRA		01011XXXYYYIII00
	ADDU	01100XXXYYYZZZ00
	SUBU	01101XXXYYYZZZ00

### I

	指令	编码
	ADDSP	01110IIIIIIII000
	LW_SP	01111XXXIIIIIIII
	SW_SP	10000XXXIIIIIIII
	ADDIU	10001XXXIIIIIIII
	*SLTI	10010XXXIIIIIIII
	*ADDSP3	10011XXXIIIIIIII
	LI		10100XXXIIIIIIII
	ADDIU3	10101XXXYYY0IIII
	LW		10110XXXYYYIIIII
	SW		10111XXXYYYIIIII

### B
	指令	编码
	B		11000IIIIIIIIIII
	BTEQZ	11001IIIIIIII000
	BEQZ	11010XXXIIIIIIII
	BNEZ	11011XXXIIIIIIII

### J

	指令	编码
	*JRRA	1110000000000000
	JR		11101XXX00000000

### 特殊指令

	指令	编码
	NOP		0000000000000000
