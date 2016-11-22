; This file contains a bunch of utility print out functions.

*------------------------------------------------------------------------------
* CLEAR_CONSOLE SubRoutine
*
* Clears the console output. 
*------------------------------------------------------------------------------
printSlash:
    MOVE.B      #'/', (A1)+
    JSR         printOutSymbolColor
    RTS
printMoney:
    MOVE.B      #'$', (A1)+
    JSR         printOutSymbolColor
    RTS
printHash:      * Alias
printPound:
    MOVE.B      #'#', (A1)+
    JSR         printOutSymbolColor
    RTS
printLeftParenth:
    MOVE.B      #'(', (A1)+
    JSR         printOutSymbolColor
    RTS
printRightParenth:
    MOVE.B      #')', (A1)+
    JSR         printOutSymbolColor
    RTS
printComma:
    MOVE.B      #',', (A1)+
    JSR         printOutSymbolColor
    RTS  
printPlus:
    MOVE.B      #'+', (A1)+
    JSR         printOutSymbolColor
    RTS  
printMinus:
    MOVE.B      #'-', (A1)+
    JSR         printOutSymbolColor
    RTS  
printPercent:
    MOVE.B      #'%', (A1)+
    JSR         printOutSymbolColor
    RTS  
printNewLine:
    MOVE.W      #CRNL, (A1)+    
;    MOVE.B      #CR, (A1)+   
;    MOVE.B      #NL, (A1)+
    JSR         PRINT_OUT
    RTS 
printTab:
    MOVE.L      #'    ', (A1)+
    JSR         PRINT_OUT
    RTS
printDotUnknown:
    MOVE.W      #'.?', (A1)+
    JSR         printOutOpColor
    RTS
printDotByte:
    MOVE.W      #'.B', (A1)+
    JSR         printOutOpColor
    RTS
printDotWord:
    MOVE.W      #'.W', (A1)+
    JSR         printOutOpColor
    RTS
printDotLong:
    MOVE.W      #'.L', (A1)+
    JSR         printOutOpColor
    RTS
printCCR:
    MOVE.W      #'CC', (A1)+
    MOVE.B      #'R',(A1)+
    JSR         printOutEaColor
    RTS
printSR:
    MOVE.W      #'SR', (A1)+
    JSR         printOutEaColor
    RTS

;--------------------------------------------------------------------------------------------------
; C O R E _ M E T H O D S
printOutOpColor:
    MOVEM.L     D1, -(SP)       * Save register
    MOVE.L      #$0011FF11, D1  * Green
    JSR         SET_COLOR_RAW
    JSR         PRINT_OUT
    MOVEM.L (SP)+, D1 
    RTS
printOutEaColor:
    MOVEM.L     D1, -(SP)       * Save register
    MOVE.L      #$00AAAAAA, D1  * Gray
    JSR         SET_COLOR_RAW
    JSR         PRINT_OUT
    MOVEM.L (SP)+, D1 
    RTS
printOutSymbolColor:
    MOVEM.L     D1, -(SP)       * Save register
    MOVE.L      #$000088FF, D1  * Orange
    JSR         SET_COLOR_RAW
    JSR         PRINT_OUT
    MOVEM.L (SP)+, D1 
    RTS
printOutAddrColor:
printOutPromptColor:
*printOutWhite:
    MOVEM.L     D1, -(SP)       * Save register
    MOVE.L      #$00FFFFFF, D1
    JSR         SET_COLOR_RAW
    JSR         PRINT_OUT
    MOVEM.L (SP)+, D1
    RTS
printOutErrorColor:
*printOutRed:
    MOVEM.L     D1, -(SP)       * Save register
    MOVE.L      #$001111FF, D1
    JSR         SET_COLOR_RAW
    JSR         PRINT_OUT
    MOVEM.L (SP)+, D1
    RTS    
* Performs setting of the color. Requires that the color LONG be pushed to d1 first.
SET_COLOR_RAW:		* This is where the magic happens.
    MOVEM.L         D0/D2,-(SP)         * Restore registers
    CLR.L           D2
    MOVE.L          #21,    d0  Task type for setting font properties. (Task 21)
    TRAP            #15         Actually SET the font properties.
    MOVEM.L         (SP)+,D0/D2         * Restore registers  
    RTS

**------------------------------------------------------------------------------    
* Add null to (A1)+, then print contents of (A1) when A1 = #ADDR_OUT
PRINT_OUT:

    MOVE.B      #NULL, (A1)+
    MOVE.L      #ADDR_OUT, A1
    
    MOVEM.L     D0/D1, -(SP)        * Save registers
    MOVE.B      #14, D0
    TRAP        #15
    MOVEM.L     (SP)+,D0/D1         * Restore registers
    JSR         RESET_OUT
    RTS   
RESET_OUT:
    MOVE.L  #ADDR_OUT, A1
    RTS
 

* -----------------------------------------------------------------------------
* The only input is D5. The output is D5. Reverses the long word contents of D5 
REVERSE_D5_LONG:
    MOVEM.L D0/D1, -(SP)
    CLR.L   D0      * D0 will be our counter.
    MOVE.B  #31, D0
REVERSE_D5_loop:
    BTST    #0, D5
    BEQ     REVERSE_D5_0
    BRA     REVERSE_D5_1
REVERSE_D5_0:
    BCLR    D0, D1
    BRA     REVERSE_D5_while
REVERSE_D5_1:    
    BSET    D0, D1
    BRA     REVERSE_D5_while
REVERSE_D5_while:
    ROR.L   #1, D5
    CMPI.B  #0, D0                  * are we done looping?
    DBEQ    D0, REVERSE_D5_loop
REVERSE_D5_EXIT:
    MOVE.L  D1, D5
    MOVEM.L (SP)+, D0/D1
    RTS
   
* -----------------------------------------------------------------------------
* The only input is D5. All other data registers are protected. Converts the
* contents of D5 into ascii and pushes it to the end of the string buffer 
* located at (A1)+. It is then up to the user to do actual print operations. 
APPEND_D5_AUTO: * Automatically detect correct size based on contents of 
    CMP.B   #0, ADDR_EA_SIZE
    BEQ     APPEND_D5_BYTE    
    CMP.B   #1, ADDR_EA_SIZE
    BEQ     APPEND_D5_WORD   
    CMP.B   #2, ADDR_EA_SIZE
    BEQ     APPEND_D5_LONG
    RTS     * Invalid size...
APPEND_D5_BYTE:
    MOVEM.L     D0-D4/D6/D7/A3, -(SP)        * Save registers
    MOVE.L  D5,D3       ; current addr
    ROR.L   #8, D3      ; Move printable area to left most part
    MOVE.L  #2, D7      ; set counter
    BRA     APPEND_D5_INIT
APPEND_D5_WORD:
    MOVEM.L     D0-D4/D6/D7/A3, -(SP)        * Save registers
    MOVE.L  D5,D3       ; current addr
    ROR.L   #8, D3      ; Move printable area to left most part
    ROR.L   #8, D3      ; Move printable area to left most part
    MOVE.L  #4, D7      ; set counter
    BRA     APPEND_D5_INIT
APPEND_D5_LONG:
    MOVEM.L     D0-D4/D6/D7/A3, -(SP)        * Save registers
    MOVE.L  D5,D3       ; current addr
    MOVE.L  #8, D7      ; set counter
    BRA     APPEND_D5_INIT

APPEND_D5_INIT:
    JSR     RESET_OUT
    lea     s_AsciiArray, A3
    BRA     APPEND_D5_SubLoop
APPEND_D5_SubLoop:   
    ROL.L   #4, D3              ; Rotate 1 hex letter. We start with the highest, work our way over to the lowest. 
    MOVE.B  D3, D4
    ANDI.W  #$000F,D4           ; We only want the last nibble.
    ;LSL.W   #1, D4              ; Multiply by 2 because it is 2 bytes per array index.
    MOVE.B  (A3, D4.W), (A1)+   ; Move array index D4 to (A1), then increment.
    
    SUBI.B  #1,D7       ; Decrement
    CMPI.B  #0,D7       ; Finished looping?
    BGT     APPEND_D5_SubLoop
    MOVEM.L (SP)+, D0-D4/D6/D7/A3        * Restore registers
    RTS



* -----------------------------------------------------------------------------
* The only input is A3. The output goes into (A1)+. 
* The point of this is so that you can add a long string to the A1 output
* buffer without worrying about where your A1 pointer is, or worrying about
* overwriting A3's contents. Your string MUST end in NULL though.
* Modifies A1. 
APPEND_A3:
    MOVEM.L     D0-D7/A0/A2/A4-A6, -(SP)        * Save registers
APPEND_A3_SubLoop:
    MOVE.B      (A3)+, D4
    CMPI.B      #NULL, D4
    BEQ         APPEND_A3_EXIT
    MOVE.B      D4, (A1)+
    BRA         APPEND_A3_SubLoop
APPEND_A3_EXIT
    MOVEM.L (SP)+, D0-D7/A0/A2/A4-A6        * Restore registers
    RTS

*------------------------------------------------------------------------------
* NEXT_x SubRoutine
*
* Moves the Address pointer forward while at the same time moving the specified
* chunk of data to D3. This will handle the pre-zeroing of D3 just fine.
*------------------------------------------------------------------------------   
NEXT_BYTE:
    ;JSR NEXT_WORD       ; Bytes are stored along word boundaries anyways... weeeeird.
    ;RTS
    CLR.L   D3  ; Zero out D3
    MOVE.B (A5)+, D3        ; Move data at A5 to D3, then move A5 forward 1 byte.
    RTS                     ; Return
NEXT_WORD:
    CLR.L   D3  ; Zero out D3
    MOVE.B (A5)+, D3        ; D3 = memory[A5++];
    ROR.W   #8, D3          ; Push contents of D3 over by a byte length
    MOVE.B (A5)+, D3        ; D3 = memory[A5++];
    RTS
NEXT_LONG:
    CLR.L   D3  ; Zero out D3
    MOVE.B (A5)+, D3
    ROR.W   #8, D3
    MOVE.B (A5)+, D3
    SWAP D3                 ; Rotate first byte to be last byte
    MOVE.B (A5)+, D3
    ROR.W   #8, D3
    MOVE.B (A5)+, D3
    RTS







































*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
