
;----------------------------------------------------------------------------------------------------
; Layer 1 and 2
DetermineOpCode:
;----------------------------------------------------------------------------------------------------
	MOVE.W	D3,D4
	CMPI.L	#$003c, D4
	BNE		not_003c_ORI
	JMP		isOp_003c_ORI_TO_CCR
not_003c_ORI:	* Maybe it is ORI_TO_SR?
	MOVE.L	D3, D4
	CMPI.L	#$007c, D4
	BNE		not_007c_ORI
	JMP		isOp_007c_ORI_TO_SR
not_007c_ORI:	* Maybe it is ANDI_TO_CCR?
	MOVE.L	D3, D4
	CMPI.L	#$023c, D4
	BNE		not_023c_ANDI
	JMP		isOp_023c_ANDI_TO_CCR
not_023c_ANDI:	* Maybe it is ANDI_TO_SR?
	MOVE.L	D3, D4
	CMPI.L	#$027c, D4
	BNE		not_027c_ANDI
	JMP		isOp_027c_ANDI_TO_SR
not_027c_ANDI:	* Maybe it is EORI_TO_CCR?
	MOVE.L	D3, D4
	CMPI.L	#$0a3c, D4
	BNE		not_0a3c_EORI
	JMP		isOp_0a3c_EORI_TO_CCR
not_0a3c_EORI:	* Maybe it is EORI_TO_SR?
	MOVE.L	D3, D4
	CMPI.L	#$0a7c, D4
	BNE		not_0a7c_EORI
	JMP		isOp_0a7c_EORI_TO_SR
not_0a7c_EORI:	* Maybe it is ILLEGAL?
	MOVE.L	D3, D4
	CMPI.L	#$4afc, D4
	BNE		not_4afc_ILLEGAL
	JMP		isOp_4afc_ILLEGAL
not_4afc_ILLEGAL:	* Maybe it is RESET?
	MOVE.L	D3, D4
	CMPI.L	#$4e70, D4
	BNE		not_4e70_RESET
	JMP		isOp_4e70_RESET
not_4e70_RESET:	* Maybe it is NOP?
	MOVE.L	D3, D4
	CMPI.L	#$4e71, D4
	BNE		not_4e71_NOP
	JMP		isOp_4e71_NOP
not_4e71_NOP:	* Maybe it is STOP?
	MOVE.L	D3, D4
	CMPI.L	#$4e72, D4
	BNE		not_4e72_STOP
	JMP		isOp_4e72_STOP
not_4e72_STOP:	* Maybe it is RTE?
	MOVE.L	D3, D4
	CMPI.L	#$4e73, D4
	BNE		not_4e73_RTE
	JMP		isOp_4e73_RTE
not_4e73_RTE:	* Maybe it is RTS?
	MOVE.L	D3, D4
	CMPI.L	#$4e75, D4
	BNE		not_4e75_RTS
	JMP		isOp_4e75_RTS
not_4e75_RTS:	* Maybe it is TRAPV?
	MOVE.L	D3, D4
	CMPI.L	#$4e76, D4
	BNE		not_4e76_TRAPV
	JMP		isOp_4e76_TRAPV
not_4e76_TRAPV:	* Maybe it is RTR?
	MOVE.L	D3, D4
	CMPI.L	#$4e77, D4
	BNE		not_4e77_RTR
	JMP		isOp_4e77_RTR
not_4e77_RTR:	* Maybe it is BTST?
	MOVE.L	D3, D4
	ANDI.L	#$ffc0, D4
	CMPI.L	#$0800, D4
	BNE		not_0800_BTST
	JMP		isOp_0800_BTST
not_0800_BTST:	* Maybe it is BCHG?
	MOVE.L	D3, D4
	ANDI.L	#$ffc0, D4
	CMPI.L	#$0840, D4
	BNE		not_0840_BCHG
	JMP		isOp_0840_BCHG
not_0840_BCHG:	* Maybe it is BCLR?
	MOVE.L	D3, D4
	ANDI.L	#$ffc0, D4
	CMPI.L	#$0880, D4
	BNE		not_0880_BCLR
	JMP		isOp_0880_BCLR
not_0880_BCLR:	* Maybe it is BSET?
	MOVE.L	D3, D4
	ANDI.L	#$ffc0, D4
	CMPI.L	#$08c0, D4
	BNE		not_08c0_BSET
	JMP		isOp_08c0_BSET
not_08c0_BSET:	* Maybe it is MOVE_FROM_SR?
	MOVE.L	D3, D4
	ANDI.L	#$ffc0, D4
	CMPI.L	#$40c0, D4
	BNE		not_40c0_MOVE
	JMP		isOp_40c0_MOVE_FROM_SR
not_40c0_MOVE:	* Maybe it is MOVE_TO_CCR?
	MOVE.L	D3, D4
	ANDI.L	#$ffc0, D4
	CMPI.L	#$44c0, D4
	BNE		not_44c0_MOVE
	JMP		isOp_44c0_MOVE_TO_CCR
not_44c0_MOVE:	* Maybe it is MOVE_TO_SR?
	MOVE.L	D3, D4
	ANDI.L	#$ffc0, D4
	CMPI.L	#$46c0, D4
	BNE		not_46c0_MOVE
	JMP		isOp_46c0_MOVE_TO_SR
not_46c0_MOVE:	* Maybe it is NBCD?
	MOVE.L	D3, D4
	ANDI.L	#$ffc0, D4
	CMPI.L	#$4800, D4
	BNE		not_4800_NBCD
	JMP		isOp_4800_NBCD
not_4800_NBCD:	* Maybe it is PEA?
	MOVE.L	D3, D4
	ANDI.L	#$ffc0, D4
	CMPI.L	#$4840, D4
	BNE		not_4840_PEA
	JMP		isOp_4840_PEA
not_4840_PEA:	* Maybe it is TAS?
	MOVE.L	D3, D4
	ANDI.L	#$ffc0, D4
	CMPI.L	#$4ac0, D4
	BNE		not_4ac0_TAS
	JMP		isOp_4ac0_TAS
not_4ac0_TAS:	* Maybe it is JSR?
	MOVE.L	D3, D4
	ANDI.L	#$ffc0, D4
	CMPI.L	#$4e80, D4
	BNE		not_4e80_JSR
	JMP		isOp_4e80_JSR
not_4e80_JSR:	* Maybe it is JMP?
	MOVE.L	D3, D4
	ANDI.L	#$ffc0, D4
	CMPI.L	#$4ec0, D4
	BNE		not_4ec0_JMP
	JMP		isOp_4ec0_JMP
not_4ec0_JMP:	* Maybe it is ASR?
	MOVE.L	D3, D4
	ANDI.L	#$ffc0, D4
	CMPI.L	#$e0c0, D4
	BNE		not_e0c0_ASR
	JMP		isOp_e0c0_ASR
not_e0c0_ASR:	* Maybe it is ASL?
	MOVE.L	D3, D4
	ANDI.L	#$ffc0, D4
	CMPI.L	#$e1c0, D4
	BNE		not_e1c0_ASL
	JMP		isOp_e1c0_ASL
not_e1c0_ASL:	* Maybe it is LSR?
	MOVE.L	D3, D4
	ANDI.L	#$ffc0, D4
	CMPI.L	#$e2c0, D4
	BNE		not_e2c0_LSR
	JMP		isOp_e2c0_LSR
not_e2c0_LSR:	* Maybe it is LSL?
	MOVE.L	D3, D4
	ANDI.L	#$ffc0, D4
	CMPI.L	#$e3c0, D4
	BNE		not_e3c0_LSL
	JMP		isOp_e3c0_LSL
not_e3c0_LSL:	* Maybe it is ROXR?
	MOVE.L	D3, D4
	ANDI.L	#$ffc0, D4
	CMPI.L	#$e4c0, D4
	BNE		not_e4c0_ROXR
	JMP		isOp_e4c0_ROXR
not_e4c0_ROXR:	* Maybe it is ROXL?
	MOVE.L	D3, D4
	ANDI.L	#$ffc0, D4
	CMPI.L	#$e5c0, D4
	BNE		not_e5c0_ROXL
	JMP		isOp_e5c0_ROXL
not_e5c0_ROXL:	* Maybe it is ROR?
	MOVE.L	D3, D4
	ANDI.L	#$ffc0, D4
	CMPI.L	#$e6c0, D4
	BNE		not_e6c0_ROR
	JMP		isOp_e6c0_ROR
not_e6c0_ROR:	* Maybe it is ROL?
	MOVE.L	D3, D4
	ANDI.L	#$ffc0, D4
	CMPI.L	#$e7c0, D4
	BNE		not_e7c0_ROL
	JMP		isOp_e7c0_ROL
not_e7c0_ROL:	* Maybe it is MOVEM_D0?
	MOVE.L	D3, D4
	ANDI.L	#$ff80, D4
	CMPI.L	#$4880, D4
	BNE		not_4880_MOVEM
	JMP		isOp_4880_MOVEM_D0
not_4880_MOVEM:	* Maybe it is MOVEM_D1?
	MOVE.L	D3, D4
	ANDI.L	#$ff80, D4
	CMPI.L	#$4c80, D4
	BNE		not_4c80_MOVEM
	JMP		isOp_4c80_MOVEM_D1
not_4c80_MOVEM:	* Maybe it is ORI?
	MOVE.L	D3, D4
	ANDI.L	#$ff00, D4
	CMPI.L	#$0000, D4
	BNE		not_0000_ORI
	JMP		isOp_0000_ORI
not_0000_ORI:	* Maybe it is ANDI?
	MOVE.L	D3, D4
	ANDI.L	#$ff00, D4
	CMPI.L	#$0200, D4
	BNE		not_0200_ANDI
	JMP		isOp_0200_ANDI
not_0200_ANDI:	* Maybe it is SUBI?
	MOVE.L	D3, D4
	ANDI.L	#$ff00, D4
	CMPI.L	#$0400, D4
	BNE		not_0400_SUBI
	JMP		isOp_0400_SUBI
not_0400_SUBI:	* Maybe it is ADDI?
	MOVE.L	D3, D4
	ANDI.L	#$ff00, D4
	CMPI.L	#$0600, D4
	BNE		not_0600_ADDI
	JMP		isOp_0600_ADDI
not_0600_ADDI:	* Maybe it is EORI?
	MOVE.L	D3, D4
	ANDI.L	#$ff00, D4
	CMPI.L	#$0a00, D4
	BNE		not_0a00_EORI
	JMP		isOp_0a00_EORI
not_0a00_EORI:	* Maybe it is CMPI?
	MOVE.L	D3, D4
	ANDI.L	#$ff00, D4
	CMPI.L	#$0c00, D4
	BNE		not_0c00_CMPI
	JMP		isOp_0c00_CMPI
not_0c00_CMPI:	* Maybe it is NEGX?
	MOVE.L	D3, D4
	ANDI.L	#$ff00, D4
	CMPI.L	#$4000, D4
	BNE		not_4000_NEGX
	JMP		isOp_4000_NEGX
not_4000_NEGX:	* Maybe it is CLR?
	MOVE.L	D3, D4
	ANDI.L	#$ff00, D4
	CMPI.L	#$4200, D4
	BNE		not_4200_CLR
	JMP		isOp_4200_CLR
not_4200_CLR:	* Maybe it is NEG?
	MOVE.L	D3, D4
	ANDI.L	#$ff00, D4
	CMPI.L	#$4400, D4
	BNE		not_4400_NEG
	JMP		isOp_4400_NEG
not_4400_NEG:	* Maybe it is NOT?
	MOVE.L	D3, D4
	ANDI.L	#$ff00, D4
	CMPI.L	#$4600, D4
	BNE		not_4600_NOT
	JMP		isOp_4600_NOT
not_4600_NOT:	* Maybe it is TST?
	MOVE.L	D3, D4
	ANDI.L	#$ff00, D4
	CMPI.L	#$4a00, D4
	BNE		not_4a00_TST
	JMP		isOp_4a00_TST
not_4a00_TST:	* Maybe it is LEA?
	MOVE.L	D3, D4
	ANDI.L	#$f1c0, D4
	CMPI.L	#$41c0, D4
	BNE		not_41c0_LEA
	JMP		isOp_41c0_LEA
not_41c0_LEA:	* Maybe it is DIVU_WORD?
	MOVE.L	D3, D4
	ANDI.L	#$f1c0, D4
	CMPI.L	#$80c0, D4
	BNE		not_80c0_DIVU
	JMP		isOp_80c0_DIVU_WORD
not_80c0_DIVU:	* Maybe it is DIVS_WORD?
	MOVE.L	D3, D4
	ANDI.L	#$f1c0, D4
	CMPI.L	#$81c0, D4
	BNE		not_81c0_DIVS
	JMP		isOp_81c0_DIVS_WORD
not_81c0_DIVS:	* Maybe it is MULU_WORD?
	MOVE.L	D3, D4
	ANDI.L	#$f1c0, D4
	CMPI.L	#$c0c0, D4
	BNE		not_c0c0_MULU
	JMP		isOp_c0c0_MULU_WORD
not_c0c0_MULU:	* Maybe it is MULS_WORD?
	MOVE.L	D3, D4
	ANDI.L	#$f1c0, D4
	CMPI.L	#$c1c0, D4
	BNE		not_c1c0_MULS
	JMP		isOp_c1c0_MULS_WORD
not_c1c0_MULS:	* Maybe it is ASR?
	MOVE.L	D3, D4
	ANDI.L	#$f118, D4
	CMPI.L	#$e000, D4
	BNE		not_e000_ASR
	JMP		isOp_e000_ASR
not_e000_ASR:	* Maybe it is LSR?
	MOVE.L	D3, D4
	ANDI.L	#$f118, D4
	CMPI.L	#$e008, D4
	BNE		not_e008_LSR
	JMP		isOp_e008_LSR
not_e008_LSR:	* Maybe it is ROXR?
	MOVE.L	D3, D4
	ANDI.L	#$f118, D4
	CMPI.L	#$e010, D4
	BNE		not_e010_ROXR
	JMP		isOp_e010_ROXR
not_e010_ROXR:	* Maybe it is ROR?
	MOVE.L	D3, D4
	ANDI.L	#$f118, D4
	CMPI.L	#$e018, D4
	BNE		not_e018_ROR
	JMP		isOp_e018_ROR
not_e018_ROR:	* Maybe it is ASL?
	MOVE.L	D3, D4
	ANDI.L	#$f118, D4
	CMPI.L	#$e100, D4
	BNE		not_e100_ASL
	JMP		isOp_e100_ASL
not_e100_ASL:	* Maybe it is LSL?
	MOVE.L	D3, D4
	ANDI.L	#$f118, D4
	CMPI.L	#$e108, D4
	BNE		not_e108_LSL
	JMP		isOp_e108_LSL
not_e108_LSL:	* Maybe it is ROXL?
	MOVE.L	D3, D4
	ANDI.L	#$f118, D4
	CMPI.L	#$e110, D4
	BNE		not_e110_ROXL
	JMP		isOp_e110_ROXL
not_e110_ROXL:	* Maybe it is ROL?
	MOVE.L	D3, D4
	ANDI.L	#$f118, D4
	CMPI.L	#$e118, D4
	BNE		not_e118_ROL
	JMP		isOp_e118_ROL
not_e118_ROL:	* Maybe it is SUBA?
	MOVE.L	D3, D4
	ANDI.L	#$f0c0, D4
	CMPI.L	#$90c0, D4
	BNE		not_90c0_SUBA
	JMP		isOp_90c0_SUBA
not_90c0_SUBA:	* Maybe it is CMPA?
	MOVE.L	D3, D4
	ANDI.L	#$f0c0, D4
	CMPI.L	#$b0c0, D4
	BNE		not_b0c0_CMPA
	JMP		isOp_b0c0_CMPA
not_b0c0_CMPA:	* Maybe it is ADDA?
	MOVE.L	D3, D4
	ANDI.L	#$f0c0, D4
	CMPI.L	#$d0c0, D4
	BNE		not_d0c0_ADDA
	JMP		isOp_d0c0_ADDA
not_d0c0_ADDA:	* Maybe it is MOVEA?
	MOVE.L	D3, D4
	ANDI.L	#$c1c0, D4
	CMPI.L	#$0040, D4
	BNE		not_0040_MOVEA
	JMP		isOp_0040_MOVEA
not_0040_MOVEA:	* Maybe it is MOVEQ?
	MOVE.L	D3, D4
	ANDI.L	#$f100, D4
	CMPI.L	#$7000, D4
	BNE		not_7000_MOVEQ
	JMP		isOp_7000_MOVEQ
not_7000_MOVEQ:	* Maybe it is CMP?
	MOVE.L	D3, D4
	ANDI.L	#$f100, D4
	CMPI.L	#$b000, D4
	BNE		not_b000_CMP
	JMP		isOp_b000_CMP
not_b000_CMP:	* Maybe it is EOR?
	MOVE.L	D3, D4
	ANDI.L	#$f100, D4
	CMPI.L	#$b100, D4
	BNE		not_b100_EOR
	JMP		isOp_b100_EOR
not_b100_EOR:	* Maybe it is Bcc?
	MOVE.L	D3, D4
	ANDI.L	#$f000, D4
	CMPI.L	#$6000, D4
	BNE		not_6000_B
	JMP		isOp_6000_Bcc
not_6000_B:	* Maybe it is OR?
	MOVE.L	D3, D4
	ANDI.L	#$f000, D4
	CMPI.L	#$8000, D4
	BNE		not_8000_OR
	JMP		isOp_8000_OR
not_8000_OR:	* Maybe it is SUB?
	MOVE.L	D3, D4
	ANDI.L	#$f000, D4
	CMPI.L	#$9000, D4
	BNE		not_9000_SUB
	JMP		isOp_9000_SUB
not_9000_SUB:	* Maybe it is AND?
	MOVE.L	D3, D4
	ANDI.L	#$f000, D4
	CMPI.L	#$c000, D4
	BNE		not_c000_AND
	JMP		isOp_c000_AND
not_c000_AND:	* Maybe it is ADD?
	MOVE.L	D3, D4
	ANDI.L	#$f000, D4
	CMPI.L	#$d000, D4
	BNE		not_d000_ADD
	JMP		isOp_d000_ADD
not_d000_ADD:	* Maybe it is MOVE?
	MOVE.L	D3, D4
	ANDI.L	#$c000, D4
	CMPI.L	#$0000, D4
	BNE		not_0000_MOVE
	JMP		isOp_0000_MOVE
not_0000_MOVE:	* Maybe it is Invalid_Opcode?
	MOVE.L	D3, D4
	ANDI.L	#$0000, D4
	CMPI.L	#$0000, D4
	BNE		not_0000_INVALID
	JMP		isOp_0000_Invalid_Opcode
not_0000_INVALID:
	JMP	isOp_0000_Invalid_Opcode
;----------------------------------------------------------------------------------------------------

;----------------------------------------------------------------------------------------------------
; Layer 3
isOp_003c_ORI_TO_CCR:
	LEA		opName_ORI, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_ori_to_ccr
isOp_0a3c_EORI_TO_CCR:
	LEA		opName_EORI, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_ori_to_ccr
isOp_023c_ANDI_TO_CCR:
	LEA		opName_ANDI, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_ori_to_ccr
isOp_027c_ANDI_TO_SR:
	LEA		opName_ANDI, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_ori_to_sr
isOp_0a7c_EORI_TO_SR:
	LEA		opName_EORI, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_ori_to_sr
isOp_007c_ORI_TO_SR:
	LEA		opName_ORI, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_ori_to_sr
isOp_0800_BTST:
	LEA		opName_BTST, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_jsr
isOp_0840_BCHG:
	LEA		opName_BCHG, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_jsr
isOp_0880_BCLR:
	LEA		opName_BCLR, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_jsr
isOp_08c0_BSET:
	LEA		opName_BSET, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_jsr
isOp_0000_ORI:
	LEA		opName_ORI, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_ori
isOp_0200_ANDI:
	LEA		opName_ANDI, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_ori
isOp_0400_SUBI:
	LEA		opName_SUBI, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_ori
isOp_0600_ADDI:
	LEA		opName_ADDI, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_ori
isOp_0a00_EORI:
	LEA		opName_EORI, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_ori
isOp_0c00_CMPI:
	LEA		opName_CMPI, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_ori
isOp_0040_MOVEA:
	LEA		opName_MOVEA, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_move
isOp_0000_MOVE:
	LEA		opName_MOVE, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_move
isOp_4e70_RESET:
	LEA		opName_RESET, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	RTS
isOp_4e72_STOP:
	LEA		opName_STOP, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_imm_word
isOp_4e73_RTE:
	LEA		opName_RTE, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	RTS
isOp_4e75_RTS:
	LEA		opName_RTS, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	RTS
isOp_4e76_TRAPV:
	LEA		opName_TRAPV, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	RTS
isOp_4e77_RTR:
	LEA		opName_RTR, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	RTS
isOp_4afc_ILLEGAL:
	LEA		opName_ILLEGAL, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	RTS
isOp_4e71_NOP:
	LEA		opName_NOP, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	RTS
isOp_40c0_MOVE_FROM_SR:
	LEA		opName_MOVE, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_move_from_sr
isOp_44c0_MOVE_TO_CCR:
	LEA		opName_MOVE, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_move_to_ccr
isOp_46c0_MOVE_TO_SR:
	LEA		opName_MOVE, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_move_to_sr
isOp_4e80_JSR:
	LEA		opName_JSR, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_jsr
isOp_4ec0_JMP:
	LEA		opName_JMP, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_jsr
isOp_4800_NBCD:
	LEA		opName_NBCD, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_jsr
isOp_4ac0_TAS:
	LEA		opName_TAS, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_jsr
isOp_4840_PEA:
	LEA		opName_PEA, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_jsr
isOp_4c80_MOVEM_D1:
	LEA		opName_MOVEM, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_movem
isOp_4880_MOVEM_D0:
	LEA		opName_MOVEM, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_movem
isOp_4000_NEGX:
	LEA		opName_NEGX, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_clr
isOp_4200_CLR:
	LEA		opName_CLR, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_clr
isOp_4400_NEG:
	LEA		opName_NEG, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_clr
isOp_4600_NOT:
	LEA		opName_NOT, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_clr
isOp_4a00_TST:
	LEA		opName_TST, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_clr
isOp_41c0_LEA:
	LEA		opName_LEA, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_lea
isOp_6000_Bcc:
	LEA		opName_B, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	LEA	s_BccArray, A3
	CLR.L	D4
	MOVE.B	ADDR_OP_0F00, D4 ; Move the condition codes where we want them.
	LSL.W	#1, D4 	; Multiply by 2 because it is 2 bytes per array index. 
	JSR		RESET_OUT
	MOVE.W	(A3, D4.W), (A1)+	; Move array index D4 to (A1), then increment.	JSR	printOutOpColor 
	JMP		ea_ea_displacement
isOp_7000_MOVEQ:
	LEA		opName_MOVEQ, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_moveq
isOp_80c0_DIVU_WORD:
	LEA		opName_DIVU, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_divs_word
isOp_81c0_DIVS_WORD:
	LEA		opName_DIVS, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_divs_word
isOp_8000_OR:
	LEA		opName_OR, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_and
isOp_90c0_SUBA:
	LEA		opName_SUBA, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_cmpa
isOp_9000_SUB:
	LEA		opName_SUB, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_and
isOp_b0c0_CMPA:
	LEA		opName_CMPA, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_cmpa
isOp_b100_EOR:
	LEA		opName_EOR, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_cmp
isOp_b000_CMP:
	LEA		opName_CMP, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_cmp
isOp_c0c0_MULU_WORD:
	LEA		opName_MULU, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_divs_word
isOp_c1c0_MULS_WORD:
	LEA		opName_MULS, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_divs_word
isOp_c000_AND:
	LEA		opName_AND, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_and
isOp_d0c0_ADDA:
	LEA		opName_ADDA, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_cmpa
isOp_d000_ADD:
	LEA		opName_ADD, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_and
isOp_e0c0_ASR:
	LEA		opName_ASR, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_jsr
isOp_e1c0_ASL:
	LEA		opName_ASL, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_jsr
isOp_e2c0_LSR:
	LEA		opName_LSR, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_jsr
isOp_e3c0_LSL:
	LEA		opName_LSL, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_jsr
isOp_e4c0_ROXR:
	LEA		opName_ROXR, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_jsr
isOp_e5c0_ROXL:
	LEA		opName_ROXL, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_jsr
isOp_e6c0_ROR:
	LEA		opName_ROR, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_jsr
isOp_e7c0_ROL:
	LEA		opName_ROL, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_jsr
isOp_e000_ASR:
	LEA		opName_ASR, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_rotation
isOp_e100_ASL:
	LEA		opName_ASL, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_rotation
isOp_e008_LSR:
	LEA		opName_LSR, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_rotation
isOp_e108_LSL:
	LEA		opName_LSL, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_rotation
isOp_e010_ROXR:
	LEA		opName_ROXR, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_rotation
isOp_e110_ROXL:
	LEA		opName_ROXL, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_rotation
isOp_e018_ROR:
	LEA		opName_ROR, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_rotation
isOp_e118_ROL:
	LEA		opName_ROL, A3
	JSR		APPEND_A3
	JSR		printOutOpColor
	JMP		ea_pattern_rotation
isOp_0000_Invalid_Opcode:
	LEA		opName_INVALID, A3
	JSR		APPEND_A3
	JSR		printOutErrorColor
	JMP		ea_pattern_data
;----------------------------------------------------------------------------------------------------




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
