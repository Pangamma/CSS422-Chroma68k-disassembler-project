SPLASH_PAGE:
    MOVEM.L     D0/D1/D2/D3/A1   , -(SP)  * Save registers
    
    MOVE.W  #$FF00,D1           * Clear output
    MOVE    #11,D0  
    TRAP    #15

    LEA     splash_TEXT_CHROMA_TITLE ,A1
    MOVE.L  #14,D0              * Get ready to print    
    TRAP    #15                 * Print prompt      
    
    MOVE.L      #ADDR_OUT, A1           * Pause till "enter"
    MOVE.L      #2, D0					* Move A1 pointer to safe spot, then overwrite it
    TRAP        #15                     * Contents stored in A1. Pray they don't enter in a mega string.
    
    MOVE.W  #$FF00,D1                   * Clear output
    MOVE    #11,D0  
    TRAP    #15
    
    MOVEM.L (SP)+,  D0/D1/D2/D3/A1     * Restore registers
    RTS



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
