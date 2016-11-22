*-----------------------------------------------------------
* Title       : strings.x68
* Author      : Taylor Love
* Description : Contains string constants you'd use for
*               showing output to users, or anything where
*               DC.B, DC.x or whatever is used.
*-----------------------------------------------------------

;--------------------------------------------------------------------------------------------------
; io_address_inputs.x68
txtPromptEndAddr        DC.B    'Enter the 8 digit ending hexadecimal address. (Must be EVEN)',CR,LF,0
txtPromptStartAddr      DC.B    'Enter the 8 digit starting hexadecimal address.(Must be EVEN)',CR,LF,0
txtInvalidInput         DC.B    'Invalid input. Try again.',CR,LF,0
txtInvalidInputBLT      DC.B    'Starting address must be before ending address. Try again.',CR,LF,0
txtInvalidInputEven     DC.B    'Addresses must be even. Try again.',CR,LF,0

;--------------------------------------------------------------------------------------------------
; io_ask_to_go_again.x68
atga_promptMessage DC.B 'Want to run the program again? Type y for yes. Otherwise the answer is no.',CR,LF,0
atga_quitMessage DC.B   'Thanks for playing. See you next time! ',CR,LF,0


;--------------------------------------------------------------------------------------------------
; io_splash_cool.x68
bmp_enterToContinue DC.B 'Press "enter" to continue.',0
bmp_loading DC.B 'Loading...',0
; io_splash_lame.x68
splash_TEXT_CHROMA_TITLE 
	    DC.B	 '    ______ _                                    __   _____  _    _ ',CR,LF
	    DC.B	 '   / _____) |                                  / /  / ___ \| |  / )',CR,LF
	    DC.B	 '  | /     | | _   ____ ___  ____   ____       / /_ ( (   ) ) | / / ',CR,LF
	    DC.B	 '  | |     | || \ / ___) _ \|    \ / _  |     / __ \ > > < <| |< <  ',CR,LF
	    DC.B	 '  | \_____| | | | |  | |_| | | | ( ( | |    ( (__) | (___) ) | \ \ ',CR,LF
	    DC.B	 '   \______)_| |_|_|   \___/|_|_|_|\_||_|     \____/ \_____/|_|  \_)',CR,LF
	    DC.B	 '                                                                   ',CR,LF
	    DC.B	 '   _____   _                                  _     _              ',CR,LF
	    DC.B	 '  (____ \ (_)                                | |   | |             ',CR,LF
	    DC.B	 '   _   \ \ _  ___  ____  ___  ___  ____ ____ | | _ | | ____  ____  ',CR,LF
	    DC.B	 '  | |   | | |/___)/ _  |/___)/___)/ _  )    \| || \| |/ _  )/ ___) ',CR,LF
	    DC.B	 '  | |__/ /| |___ ( ( | |___ |___ ( (/ /| | | | |_) ) ( (/ /| |     ',CR,LF
	    DC.B	 '  |_____/ |_(___/ \_||_(___/(___/ \____)_|_|_|____/|_|\____)_|     ',CR,LF
        DC.B	 CR,LF,'--------------------------------------------------------------------------------',CR,LF
        DC.B    'Press "enter" to continue.',CR,LF,0
        
;--------------------------------------------------------------------------------------------------
; io_util.x68
s_AsciiArray    DC.B    '0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F' 
s_SizeArray1    DC.W    '.B','.W','.L'
s_SizeArray2    DC.W    '.W','.L'
s_SizeArray3    DC.W    '.?','.B','.L','.W'
s_DnArray       DC.W    'D0','D1','D2','D3','D4','D5','D6','D7'
s_AnArray       DC.W    'A0','A1','A2','A3','A4','A5','A6','A7'
s_RegArray      DC.B       'A7','A6','A5','A4','A3','A2','A1','A0','D7','D6','D5','D4','D3','D2','D1','D0'
s_BccArray	    DC.W	'RA','SR','HI','LS','CC','CS','NE','EQ','VC','VS','PL','MI','GE','LT','GT','LE'
s_DBccArray 	DC.W	'T','F','HI','LS','CC','CS','NE','EQ','VC','VS','PL','MI','GE','LT','GT','LE' 
s_SccArray	    DC.W	'T','F','HI','LS','CC','CS','NE','EQ','VC','VS','PL','MI','GE','LT','GT','LE'

;--------------------------------------------------------------------------------------------------
; OpCodes
;----------------------------------------------------------------------------------------------------
opLoop_enterToContinue  DC.B 'Press "enter" to continue reading.',0

;--------------------------------------------------------------------------------------------------
; OpCodes
opName_ABCD	DC.B	'ABCD',0
opName_ADD	DC.B	'ADD',0
opName_ADDA	DC.B	'ADDA',0
opName_ADDI	DC.B	'ADDI',0
opName_ADDQ	DC.B	'ADDQ',0
opName_ADDX	DC.B	'ADDX',0
opName_AND	DC.B	'AND',0
opName_ANDI	DC.B	'ANDI',0
opName_ASL	DC.B	'ASL',0
opName_ASR	DC.B	'ASR',0
opName_B	DC.B	'B',0
opName_BCHG	DC.B	'BCHG',0
opName_BCLR	DC.B	'BCLR',0
opName_BSET	DC.B	'BSET',0
opName_BTST	DC.B	'BTST',0
opName_CHK	DC.B	'CHK',0
opName_CLR	DC.B	'CLR',0
opName_CMP	DC.B	'CMP',0
opName_CMPA	DC.B	'CMPA',0
opName_CMPI	DC.B	'CMPI',0
opName_CMPM	DC.B	'CMPM',0
opName_DB	DC.B	'DB',0
opName_DIVS	DC.B	'DIVS',0
opName_DIVU	DC.B	'DIVU',0
opName_EOR	DC.B	'EOR',0
opName_EORI	DC.B	'EORI',0
opName_EXG	DC.B	'EXG',0
opName_EXT	DC.B	'EXT',0
opName_ILLEGAL	DC.B	'ILLEGAL',0
opName_INVALID	DC.B	'DATA',0
opName_JMP	DC.B	'JMP',0
opName_JSR	DC.B	'JSR',0
opName_LEA	DC.B	'LEA',0
opName_LINK	DC.B	'LINK',0
opName_LSL	DC.B	'LSL',0
opName_LSR	DC.B	'LSR',0
opName_MOVE	DC.B	'MOVE',0
opName_MOVEA	DC.B	'MOVEA',0
opName_MOVEM	DC.B	'MOVEM',0
opName_MOVEP	DC.B	'MOVEP',0
opName_MOVEQ	DC.B	'MOVEQ',0
opName_MULS	DC.B	'MULS',0
opName_MULU	DC.B	'MULU',0
opName_NBCD	DC.B	'NBCD',0
opName_NEG	DC.B	'NEG',0
opName_NEGX	DC.B	'NEGX',0
opName_NOP	DC.B	'NOP',0
opName_NOT	DC.B	'NOT',0
opName_OR	DC.B	'OR',0
opName_ORI	DC.B	'ORI',0
opName_PEA	DC.B	'PEA',0
opName_RESET	DC.B	'RESET',0
opName_ROL	DC.B	'ROL',0
opName_ROR	DC.B	'ROR',0
opName_ROXL	DC.B	'ROXL',0
opName_ROXR	DC.B	'ROXR',0
opName_RTE	DC.B	'RTE',0
opName_RTR	DC.B	'RTR',0
opName_RTS	DC.B	'RTS',0
opName_S	DC.B	'S',0
opName_SBCD	DC.B	'SBCD',0
opName_STOP	DC.B	'STOP',0
opName_SUB	DC.B	'SUB',0
opName_SUBA	DC.B	'SUBA',0
opName_SUBI	DC.B	'SUBI',0
opName_SUBQ	DC.B	'SUBQ',0
opName_SUBX	DC.B	'SUBX',0
opName_SWAP	DC.B	'SWAP',0
opName_TAS	DC.B	'TAS',0
opName_TRAP	DC.B	'TRAP',0
opName_TRAPV	DC.B	'TRAPV',0
opName_TST	DC.B	'TST',0
opName_UNLK	DC.B	'UNLK',0

eaName_CCR	DC.B	'CCR',0
eaName_SR	DC.B	'SR',0









*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
