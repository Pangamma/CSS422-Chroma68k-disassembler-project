* D5 contains yOffset
* D6 contains xOffset
* A4 contains bitmap ptr
BMP_CONTAINER_WIDTH   EQU         640
BMP_CONTAINER_HEIGHT  EQU         480
    INCLUDE 'bitmap_psg.x68'

SPLASH_PAGE: 
    MOVEM.L     D0/D1/D2/D3/D4/D5/D6/A1/A4   , -(SP)  * Save registers

    MOVE.W  #$FF00,D1           * Clear output
    MOVE    #11,D0  
    TRAP    #15
    
    LEA     bmp_loading ,A1     * Show some sort of loading message.
    MOVE.L  #14,D0              * Get ready to print    
    TRAP    #15                 * Print prompt      

    ;MOVE.b	#17,d1			    * enable double buffering
	;MOVE.b	#92,d0			    * set draw mode
	;TRAP	#15
	
	MOVE.W  #$FF00,D1           * Clear output
    MOVE    #11,D0  
    TRAP    #15
    
    MOVE.L  #$0, D5             * Zero out D5 and D6
    MOVE.L  #$0, D6
    LEA     BMP_ARRAY, A4          * Load the start addr of the bitmap array to A4


    BRA     bmp_loop
    
bmp_loop: 
    MOVE.L  (A4),D1    Set the pen color to value at A4's current address
    MOVE.B  #80, D0     
    TRAP    #15
    
    move.L  (A4)+,d1    set fill color
    move.B  #81,d0
    trap    #15         

    move.l  D6,d1       Set X1 loc
    move.l  D6,d3       Set X2 loc
    ADDI.L  #BMP_IMG_ZOOM, D3
    
    move.l  D5,d2       Set Y1 loc
    move.l  D5,d4       Set Y2 loc
    ADDI.L  #BMP_IMG_ZOOM, D4

    move.b  #87,d0
    trap    #15         draw filled rectangle
  
    ADDI.L  #BMP_IMG_ZOOM, D6     * Increment xOffset
    CMP.L   #BMP_CONTAINER_WIDTH, D6
    BGE     bmp_inc_y
    BRA     bmp_loop
    
bmp_inc_y:
    MOVE.L  #$0, D6             * reset X
    ADDI.L  #BMP_IMG_ZOOM, D5   * Increment Y
    CMP.L   #BMP_CONTAINER_HEIGHT, D5
    BGE     bmp_quit
    JMP     bmp_loop
bmp_quit:

	MOVE.b	#94,d0			* copy screen buffer to main
	TRAP		#15
	
    ;MOVE.b	#16,d1			* disable double buffering
	;MOVE.b	#92,d0			* set draw mode
	;TRAP		#15
	
    LEA     bmp_enterToContinue ,A1
    MOVE.L  #14,D0              * Get ready to print    
    TRAP    #15                 * Print prompt      
    
    * Pause till "enter"
    MOVE.L      #ADDR_OUT, A1           * Move A1 pointer to safe spot, then overwrite it
    MOVE.L      #2, D0
    TRAP        #15                     * Contents stored in A1. Pray they don't enter in a mega string.
    
    MOVE.W  #$FF00,D1           * Clear output
    MOVE    #11,D0  
    TRAP    #15
    
    MOVEM.L (SP)+,  D0/D1/D2/D3/D4/D5/D6/A1/A4     * Restore registers
    RTS
	







*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
