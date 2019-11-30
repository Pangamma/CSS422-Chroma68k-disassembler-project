TD_START:
    MOVEM.L     D0,-(A2)
    MOVEM.L     (A2)+ , D0

    MOVEM.L     D0-D4/A3, -(SP)        * Save registers
    MOVEM.L (SP)+, D0-D4/A3        * Restore registers


    MOVEM.W     D0-D4/D6/D7/A3, -(SP)        * Save registers
    MOVEM.W (SP)+, D0-D4/D6/D7/A3        * Restore registers

    MULS	D0,D3
	DIVU.W	(A3),D5	*Optional instruction
	DIVS	(A3),D5	*Optional instruction
	MULU	(A3),D5	*Optional instruction

    BRA n2
    NOP
n2:     NOP
start2		EQU	$00007000	* ORG and END address
* NOP and similar instructions. Should clearly differentiate NOP and RTS from others.
		NOP			*Required
		RTS			*Required
		STOP	#$2000  	* Not required instruction
* This is a group of ADD instructions
add_start	ADDI.W	#$4000,D0		
* This is a group of SUB instructions
subtracts	SUBA.W	(A4),A6
* Group is random data
data1		DC.B		$FF,$AA,$45,$0A
* Move instructions
moves		MOVE.B	D0,D1
data5		DC.B	'Here is some interspersed data'
* Divide and multiple optional instructions	
ands		AND.B	#$01,$4568
shifts		ASL.B	D0,D0
rolls		ROL.L	D2,D3
clear		CLR	D4
load_addr	LEA	$DC00FF00,A2
* random data	
		DC.W	2949,0411,2848,7869

compares	CMP.B	(A3),D5

* Branches	
		

* Jump and branch instructions

jmplabel	BCC	compares		
		BGT	compares		
		BLE	compares	
		
*These are not required instructions
multiply	
    MULS	D0,D3
	DIVU	(A3),D5	*Optional instruction		
    MOVE.W  SR, D1
    MOVE.W  SR, (A2)
    MOVE.W  SR, (A3)+
    MOVE.W  SR, $2000
    MOVE.W  SR, $4444000
    
    MOVEA.W ea_ea_mode, A5
    MOVE.W #$ABCD, (A2)
    MOVE.W #$ABCD, A2
    MOVE.W D4, D2
    MOVE.W D3, CCR
    MOVE.W D1, SR
    MOVE.W SR, D3

    MOVE.W  D3, CCR
    MOVE.W  (A3), CCR
    MOVE.W  $2345, CCR

    MOVE.W  D3,SR
    MOVE.W  (A3), SR
    MOVE.W  $2345, SR

    CLR.L     D3
    EORI.B  #1, D3
    EORI  #2, (A3)    
    EORI  #3, (A3)+
    EORI  #4, SR
    EORI  #5, CCR
    EORI  #5, $9990


    ORI.L   #$AAAA, D5
    ANDI.L  #$AAAA, D5
    SUBI.L  #$AAAA, D5
    MOVE.L  #$AAAA, D5
    ADDI.B  #$77, D4


    MOVEQ.L   #1, D5
    MOVEQ   #$4, D3
    MOVEQ   #$15, D1
    MOVEQ   #$18, D2
    MOVEQ   #$23, D3
    MOVEQ   #$FF, D3
    
    MOVEA.L #$00100000,A4  

TD_STOP:












*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
