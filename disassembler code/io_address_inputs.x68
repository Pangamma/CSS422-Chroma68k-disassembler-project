*------------------------------------------------------------------------------
* Program: IO section
* Written by: Taylor Love
* Date: September 10th, 2015
* Description: Has methods for printing and reading from and to the console.
*------------------------------------------------------------------------------

* This is actually a subroutine. It gathers the start and end addr into A5, and A6
* respectively. 
GET_START_AND_END_ADDRESSES:
    MOVEM.L     D0/D1/D2/D3/D4/D5/D6/D7/A1/A2/A3/A4, -(SP)        *Save registers
    
GET_START_ADDR:
    LEA     txtPromptStartAddr, A3
    JSR     APPEND_A3
    JSR     printOutPromptColor
    
    MOVEA.L #ADDR_OUT, A1  ; Set A1 to a safe read location.
    MOVE.B  #2, D0        ; Read from keyboard, store at (A1)
    TRAP    #15

    MOVE.L  (A1)+, D1
    MOVE.L  (A1)+, D2
    
    JSR     CONVERT_TO_HEX
    CMP.L   #1, D6
    BEQ     GET_START_ADDR
    
    MOVE.L  D5, A5
    BRA     GET_END_ADDR
    
GET_END_ADDR:
    LEA     txtPromptEndAddr, A3
    JSR     APPEND_A3
    JSR     printOutPromptColor

    
    MOVEA.L #ADDR_OUT, A1  ; Set A1 to a safe read location.
    MOVE.B  #2, D0        ; Read from keyboard, store at (A1)
    TRAP    #15

    MOVE.L  (A1)+, D1
    MOVE.L  (A1)+, D2
    
    JSR     CONVERT_TO_HEX
    CMP.L   #1, D6
    BEQ     GET_END_ADDR

    MOVE.L  D5, A6
    BRA     VALIDATE_ADDRESS_INPUTS
    
VALIDATE_ADDRESS_INPUTS:
    CMPA.L      A5,A6
    BLE         VALIDATE_ADDRESS_INPUTS_ERROR   * If A5 >= A6 , error
    MOVE.L      A5, D4
    BTST        #0, D4
    BNE         VALIDATE_ADDRESS_INPUTS_ERR_Even   * Must be even
    MOVE.L      A6, D4
    BTST        #0, D4
    BNE         VALIDATE_ADDRESS_INPUTS_ERR_Even   * Must be even
    BRA         VALIDATE_ADDRESS_INPUTS_SUCCESS
    
VALIDATE_ADDRESS_INPUTS_ERROR:
    LEA     txtInvalidInputBLT, A3
    JSR     APPEND_A3
    JSR     printOutErrorColor
    BRA     GET_START_ADDR
VALIDATE_ADDRESS_INPUTS_ERR_Even:
    LEA     txtInvalidInputEven, A3
    JSR     APPEND_A3
    JSR     printOutErrorColor
    BRA     GET_START_ADDR
 
VALIDATE_ADDRESS_INPUTS_SUCCESS:

    MOVE.W  #$FF00,D1           * Clear output
    MOVE    #11,D0  
    TRAP    #15
    
    MOVEM.L     (SP)+, D0/D1/D2/D3/D4/D5/D6/D7/A1/A2/A3/A4        *Restore registers
    RTS
*------------------------------------------------------------------------------
* CONVERT_TO_HEX SubRoutine
*   Input: D1, D2
*   Output: D5,D6
*   D5 = the output
*   D6 = 1 if error. 0 if no error.
*   Converts ASCII characters in D2 to hexademical.
*   Yeah, this is probably the worst part of the entire program right here. 
*   Just keep it contained in its own bubble.
*------------------------------------------------------------------------------
CONVERT_TO_HEX:
    MOVEM.L     D0/D3, -(SP)         Save registers    
    CLR.L      D0    
    CLR.L      D3     
    CLR.L      D5     
    MOVE.L      D2, D6              * prepare to work on first section.
    MOVE.L      #4 , D0             * Number of hex chars to try to read
    JSR         CONVERT_TO_HEX_AFTER_INIT
    CMP.L       #1, D6
    BEQ         GET_ADDR_LOOP_ERROR_2  
    
    MOVE.L      D1, D6
    MOVE.L      #4 , D0             * Number of hex chars to try to read
    JSR         CONVERT_TO_HEX_AFTER_INIT
    CMP.L       #1, D6
    BEQ         GET_ADDR_LOOP_ERROR_2  * This check rly isnt needed bc it is handled by caller mthd
	
    MOVEM.L     (SP)+, D0/D3            Restore Registers
    RTS
    
GET_ADDR_LOOP_ERROR_2:       * We need two, because of inception.
    MOVEM.L     (SP)+, D0/D3            Restore Registers
    RTS
    
CONVERT_TO_HEX_AFTER_INIT:

                MOVE.B  D6,D3               * Move char into D3
                LSR.L   #8,D6               * Logical shift right 8 bits to get next char
                
                CMP.B   #'0',D3         * Check for less than zero
                BLT     GET_ADDR_LOOP_ERROR
                
                CMP.B   #'9',D3         * ( X <= 9)
                BLE     NUMBER_TO_HEX
                
                CMP.B   #'A',D3         * X < A
                BLT     GET_ADDR_LOOP_ERROR

                CMP.B   #'F',D3          * ( X <= F)
                BGE     UCASE_LETTER_TO_HEX
                
                CMP.B   #'a',D3         * X < a
                BLT     GET_ADDR_LOOP_ERROR
                
                CMP.B   #'f',D3          * ( X <= f)
                BGE     LCASE_LETTER_TO_HEX

                BRA     GET_ADDR_LOOP_ERROR
NUMBER_TO_HEX:
                SUBI.B  #$30,D3         * Convert number in D3 from ASCII to hex
                BRA     NEXT_CHAR
UCASE_LETTER_TO_HEX:
                SUBI.B  #$37,D3            * Convert letter in D3 from ASCII to hex
                BRA     NEXT_CHAR               
LCASE_LETTER_TO_HEX:
                SUBI.B  #$60,D3            * Convert letter in D3 from ASCII to hex
                BRA     NEXT_CHAR                
NEXT_CHAR:                            
                ADD.B   D3, D5
                MOVE.L  #0,D3
                ROR.L   #4,D5               * Rotate bits to prepare for next char
                
                SUB.B   #1,D0               * Increment counter # of chars converted
                CMP.B   #1,D0               * Compare counter to 4
                
                
                BGE     CONVERT_TO_HEX_AFTER_INIT      * Continue if counter < 4
                MOVE.L  #0, D6                         * No errors occured, Return 0 for D6.
                RTS
                

GET_ADDR_LOOP_ERROR:
    LEA     txtInvalidInput, A3
    JSR     APPEND_A3
    JSR     printOutErrorColor
    
    MOVE.L  #$1, D6   
    RTS         













*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
