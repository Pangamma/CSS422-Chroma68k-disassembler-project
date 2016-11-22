* D5 contains yOffset
* D6 contains xOffset
* A4 contains bitmap ptr
BMP_END_CONTAINER_WIDTH   EQU         640
BMP_END_CONTAINER_HEIGHT  EQU         480
    INCLUDE 'bitmap_ask_to_go_again.x68'

ASK_TO_GO_AGAIN:                   * Contents stored in A1. Pray they don't enter in a mega string.
    MOVEM.L     D0/D1/D2/D3/D4/D5/D6/A1/A4   , -(SP)  * Save registers
	
	* Print instruction to user before rendering the image in the background.
	* The user will read the instructions before pressing enter, thus giving
	* the illusion of a very fast response time. 
    LEA     opLoop_enterToContinue ,A3
    JSR     APPEND_A3
    JSR     printOutPromptColor
  
    MOVE.b	#17,d1			    * enable double buffering
	MOVE.b	#92,d0			    * set draw mode
	TRAP	#15
    
    MOVE.W  #$FF00,D1           * Clear output
    MOVE    #11,D0  
    TRAP    #15                * Print prompt      
	
	MOVE.W  #$FF00,D1           * Clear output
    MOVE    #11,D0  
    TRAP    #15
    
    MOVE.L  #$0, D5             * Zero out D5 and D6
    MOVE.L  #$0, D6
    LEA     BMP_END_ARRAY, A4          * Load the start addr of the bitmap array to A4


    BRA     bmp_end_loop
    
bmp_end_loop: 
    MOVE.L  (A4), D1    Set the pen color to value at A4's current address
    MOVE.B  #80, D0     
    TRAP    #15
    
    move.L  (A4)+,d1    set fill color
    move.B  #81,d0
    trap    #15         

    move.l  D6,d1       Set X1 loc
    move.l  D6,d3       Set X2 loc
    ADDI.L  #BMP_END_IMG_ZOOM, D3
    
    move.l  D5,d2       Set Y1 loc
    move.l  D5,d4       Set Y2 loc
    ADDI.L  #BMP_END_IMG_ZOOM, D4

    move.b  #87,d0
    trap    #15         draw filled rectangle
  
    ADDI.L  #BMP_END_IMG_ZOOM, D6     * Increment xOffset
    CMP.L   #BMP_END_CONTAINER_WIDTH, D6
    BGE     bmp_end_inc_y
    BRA     bmp_end_loop
    
bmp_end_inc_y:
    MOVE.L  #$0, D6             * reset X
    ADDI.L  #BMP_END_IMG_ZOOM, D5   * Increment Y
    CMP.L   #BMP_END_CONTAINER_HEIGHT, D5
    BGE     bmp_end_quit
    JMP     bmp_end_loop
bmp_end_quit:

    * Pause till "enter"
    MOVE.L      #ADDR_OUT, A1           * Move A1 pointer to safe spot, then overwrite it
    MOVE.L      #2, D0
    TRAP        #15   
    
	MOVE.b	#94,d0			* copy screen buffer to main
	TRAP	#15
	
    MOVE.L  #$00FFFFFF, D1    Set the pen color to white
    MOVE.B  #80, D0     
    TRAP    #15

    move.L  #$00B24068,d1    set fill color to match background
    move.B  #81,d0
    trap    #15     
    
    MOVE.b	#16,d1			* disable double buffering
	MOVE.b	#92,d0			* set draw mode
	TRAP	#15
	

    JSR     bmp_ASK_TO_GO_AGAIN
    MOVE.W  #$FF00,D1           * Clear output
    MOVE    #11,D0  
    TRAP    #15
    
    move.L  #$00000000,d1    set fill color back to black
    move.B  #81,d0
    trap    #15     

    MOVEM.L (SP)+,  D0/D1/D2/D3/D4/D5/D6/A1/A4     * Restore registers
    RTS
	
* ------------------------
bmp_ASK_TO_GO_AGAIN:
    MOVEM.L D0/D1/D2/A1, -(SP)      *Save registers
    MOVE.L  #0, A5
    ;LEA     atga_promptMessage, A3
    ;JSR     APPEND_A3    
    ;JSR     printOutPromptColor
    
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
