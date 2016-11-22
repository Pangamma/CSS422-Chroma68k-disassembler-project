* Output is at A5. 1 = go again.
* Ask the user if they'd like retry the program.
* Also contains "show_quit_message"

ASK_TO_GO_AGAIN:
    MOVEM.L D0/D1/D2/A1, -(SP)      *Save registers
    MOVE.L  #0, A5
    LEA     atga_promptMessage, A3
    JSR     APPEND_A3    
    JSR     printOutPromptColor
    
    MOVE.L  #ADDR_OUT, A1
    MOVE.L  #2, D0
    TRAP    #15
        
    MOVE.L  #ADDR_OUT, A1
    CMP.B   #$79, (A1)
    BEQ ASK_TO_GO_AGAIN_YES
    CMP.B   #$59, (A1)
    BEQ ASK_TO_GO_AGAIN_YES
    BRA ASK_TO_GO_AGAIN_NO
    
ASK_TO_GO_AGAIN_YES:
    MOVEM.L (SP)+,D0/D1/D2/A1      *restore registers
    MOVE.L  #1, A5
    RTS
    
ASK_TO_GO_AGAIN_NO:   
    MOVEM.L (SP)+,D0/D1/D2/A1      *restore registers
    RTS

SHOW_QUIT_MSG:   
	MOVEM	D0/D1/A1, -(SP)		* Save registers
	
    MOVE.W  #$FF00,D1           * Clear output
    MOVE    #11,D0  
    TRAP    #15

    LEA     atga_quitMessage, A3
    JSR     APPEND_A3    
    JSR     printOutPromptColor

	MOVEM	(SP)+, D0/D1/A1		* Restore registers
	
    RTS




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
