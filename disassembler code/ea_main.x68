*-----------------------------------------------------------
* Title  : EA Handler
* Author : Taylor Love
* Description: Contains methods for the EA functions.
*-----------------------------------------------------------



* -----------------------------------------------------------------------------
* Great for JMP and JSR    This is for destination addr only.
ea_ea_mode:
    CMPI.B  #0, ADDR_EA_MODE
    BEQ     ea_ea_mode_000
    CMPI.B  #1, ADDR_EA_MODE
    BEQ     ea_ea_mode_001
    CMPI.B  #2, ADDR_EA_MODE
    BEQ     ea_ea_mode_010
    CMPI.B  #3, ADDR_EA_MODE
    BEQ     ea_ea_mode_011
    CMPI.B  #4, ADDR_EA_MODE
    BEQ     ea_ea_mode_100
    CMPI.B  #5, ADDR_EA_MODE
    BEQ     ea_ea_mode_101
    CMPI.B  #6, ADDR_EA_MODE
    BEQ     ea_ea_mode_110
    CMPI.B  #7, ADDR_EA_MODE
    BEQ     ea_ea_mode_111
ea_ea_mode_000:     * Dn
    JSR     eaPrintXnAsDn    
    RTS
ea_ea_mode_001:     * An
    JSR     eaPrintXnAsAn
    RTS
ea_ea_mode_010:     * (Address)
    JSR     printLeftParenth
    JSR     eaPrintXnAsAn
    JSR     printRightParenth
    RTS
ea_ea_mode_011:     * (Address)+
    JSR     printLeftParenth
    JSR     eaPrintXnAsAn
    JSR     printRightParenth
    JSR     printPlus
    RTS
ea_ea_mode_100:     * -(Address)
    JSR     printMinus
    JSR     printLeftParenth
    JSR     eaPrintXnAsAn
    JSR     printRightParenth
    RTS
ea_ea_mode_101:     * (d16, An) --------------------------------------------> DO THIS LATER
ea_ea_mode_110:     * (d8, An, Xn) -----------------------------------------> DO THIS LATER
ea_ea_mode_111:  
    CMP.B   #%000, ADDR_EA_XN
    BEQ     ea_ea_mode_111_xn_000  
    CMP.B   #%001, ADDR_EA_XN
    BEQ     ea_ea_mode_111_xn_001 
    CMP.B   #%010, ADDR_EA_XN
    BEQ     ea_ea_mode_111_xn_010  
    CMP.B   #%011, ADDR_EA_XN
    BEQ     ea_ea_mode_111_xn_011 
    CMP.B   #%100, ADDR_EA_XN
    BEQ     ea_ea_mode_111_xn_100 
ea_ea_mode_111_xn_000:  * (xxx).W
    JSR     printMoney
    JSR     NEXT_WORD
    MOVE.L  D3, D5
    JSR     APPEND_D5_WORD
	JSR		printOutEaColor
    RTS
ea_ea_mode_111_xn_001:  * (xxx).L  
    JSR     printMoney
    JSR     NEXT_LONG
    MOVE.L  D3, D5
    JSR     APPEND_D5_LONG
	JSR		printOutEaColor
    RTS
ea_ea_mode_111_xn_010:  * (D16, PC) ----------------------------------------> DO THIS LATER
ea_ea_mode_111_xn_011:  * (d8, PC, Xn) -------------------------------------> DO THIS LATER
ea_ea_mode_111_xn_100:  * immediate data
    JSR     printPound
    JSR     printMoney
    JSR     eaSkipSize
    MOVE.L  D3, D5
    JSR     APPEND_D5_AUTO
	JSR		printOutEaColor
    RTS

; P A T T E R N _ I N C L U D E S
ea_pattern_data:
    JSR     printTab
    JSR     printMoney
    MOVE.W  D3, D5
    JSR     APPEND_D5_WORD
    JSR     printOutEaColor
    RTS
ea_pattern_imm_word:
    JSR     printTab
    JSR     printHash
    JSR     printMoney
    JSR     NEXT_WORD
    MOVE.W  D3, D5
    JSR     APPEND_D5_WORD
    JSR     printOutEaColor
    RTS
ea_pattern_lea:
    JSR     printTab
    JSR     ea_getLastSixModeAndXnBits
    JSR     ea_ea_mode
    JSR     printComma
    MOVE.B  ADDR_OP_0E00, ADDR_EA_XN
    JSR     eaPrintXnAsAn
    RTS
ea_pattern_cmp:
    MOVE.B  ADDR_OP_00C0, ADDR_EA_SIZE
    JSR     eaPrintSize
    JSR     ea_getLastSixModeAndXnBits
    JSR     ea_ea_mode
    JSR     printComma
    MOVE.B  ADDR_OP_0E00, ADDR_EA_XN
    JSR     eaPrintXnAsDn
    RTS
ea_pattern_cmpa:
    MOVE.B  ADDR_OP_0100, D4    * s
    ADDI.B  #1, D4              * 0ss
    MOVE.B  D4, ADDR_EA_SIZE
    JSR     eaPrintSize
    JSR     ea_getLastSixModeAndXnBits
    JSR     ea_ea_mode
    JSR     printComma
    MOVE.B  ADDR_OP_0E00, ADDR_EA_XN
    JSR     eaPrintXnAsAn
    RTS
ea_pattern_clr: * Also great for other modes as well!
    JSR     ea_getLastSixModeAndXnBits
    MOVE.B  ADDR_OP_00C0, ADDR_EA_SIZE    ; No xform needed here.
    JSR     eaPrintSize
    JSR     ea_ea_mode
    RTS
ea_pattern_divs_word:
    MOVE.B  #1, ADDR_EA_SIZE
    JSR     eaPrintSize
    JSR     ea_getLastSixModeAndXnBits
    JSR     ea_ea_mode
    JSR     printComma
    MOVE.B  ADDR_OP_0E00, ADDR_EA_XN
    JSR     eaPrintXnAsDn
    RTS
    
ea_pattern_ori_to_sr:
    MOVE.B  #1, ADDR_EA_SIZE        * WORD
    JSR     eaPrintSize
    JSR     ea_ea_mode_111_xn_100
    JSR     printComma
    JSR     printSR
    RTS
ea_pattern_ori_to_ccr:
    MOVE.B  #0, ADDR_EA_SIZE        * Byte
    JSR     eaPrintSize
    JSR     ea_ea_mode_111_xn_100   * Immediate Data
    JSR     printComma
    JSR     printCCR
    RTS
ea_pattern_ori: * Also great for other modes as well like SUBI and ANDI
    MOVE.B  ADDR_OP_00C0, ADDR_EA_SIZE    ; No xform needed here.
    JSR     eaPrintSize
    JSR     ea_ea_mode_111_xn_100
    JSR     printComma
    JSR     ea_getLastSixModeAndXnBits
    JSR     ea_ea_mode
    RTS




ea_pattern_move_from_sr:
    MOVE.B  #1, ADDR_EA_SIZE        ; Word
    JSR     eaPrintSize
    MOVE.W  #'SR', (A1)+
    JSR     printOutEaColor
    JSR     printComma
    JSR     ea_getLastSixModeAndXnBits
    JSR     ea_ea_mode
    RTS
ea_pattern_move_to_ccr:
    MOVE.B  #0, ADDR_EA_SIZE        ; Byte
    JSR     eaPrintSize
    JSR     ea_getLastSixModeAndXnBits
    JSR     ea_ea_mode
    JSR     printComma
    MOVE.W  #'CC', (A1)+
    MOVE.B  #'R', (A1)+
    JSR     printOutEaColor
    RTS
ea_pattern_move_to_sr:
    MOVE.B  #1, ADDR_EA_SIZE        ; Word
    JSR     eaPrintSize
    JSR     ea_getLastSixModeAndXnBits
    JSR     ea_ea_mode
    JSR     printComma
    MOVE.W  #'SR', (A1)+
    JSR     printOutEaColor
    RTS
ea_pattern_move:
    MOVE.B  ADDR_OP_3000, ADDR_EA_SIZE
    JSR     eaFixSizeMovePattern
    JSR     eaPrintSize
    JSR     ea_getLastSixModeAndXnBits
    JSR     ea_ea_mode
    JSR     printComma
    CLR.L   D3
    MOVE.W  ADDR_OP_FFFF, D3
    MOVE.B  ADDR_OP_0E00, ADDR_EA_XN
    MOVE.B  ADDR_OP_01C0, ADDR_EA_MODE
    JSR     ea_ea_mode
    RTS
ea_pattern_moveq:
    MOVE.B  #2, ADDR_EA_SIZE        ; Long
    JSR     eaPrintSize
    JSR     printHash
    JSR     printMoney
    MOVE.B  ADDR_OP_00FF, D5
    JSR     APPEND_D5_BYTE
    JSR     printOutEaColor
    JSR     printComma
    MOVE.B  ADDR_OP_0E00, ADDR_EA_XN
    JSR     eaPrintXnAsDn
    RTS




* ---------------------------------------------------------
* Great for JSR, ASd, LSd, ROXd, ROd, BTST, BCHG, BCLR, BSET
* 1110 000D 11 mmm xxx
ea_pattern_jsr:
    ; Invalid size code. These op codes shouldn't ever 
    ; deal with a mode that requires size. 
    JSR     printTab
    JSR     ea_getLastSixModeAndXnBits  
    MOVE.B  #3, ADDR_EA_SIZE            
    JSR     ea_ea_mode
    RTS


*------------------------------------------------------------------------------    
ea_pattern_movem:
    MOVEM.L D4/A4/D7/D3/D5/D6, -(SP)        * Save stack
    MOVE.B  ADDR_OP_0040, D4
    ADDI.B  #1, D4
    MOVE.B  D4, ADDR_EA_SIZE        
    JSR     eaPrintSize
    JSR     ea_getLastSixModeAndXnBits
    JSR     NEXT_WORD   ; Move reg list mask to D3
    LEA     s_RegArray, A4      
    CMPI.B  #1, ADDR_OP_0400
    BEQ     ea_pattern_movem_d1
    BRA     ea_pattern_movem_d0
ea_pattern_movem_d0:    * movem  --- , -(SP)    ; A7 --> D0
    JSR     ea_pattern_movem_count_1s   * Move # 1's to D6
    MOVE.L  D3, D5
    JSR     REVERSE_D5_LONG
    ROR.L   #8, D5
    ROR.L   #8, D5
    MOVE.L  D5, D3
    JSR     ea_pattern_movem_printRegs
    JSR     printComma
    JSR     ea_ea_mode
    MOVEM.L (SP)+, D4/A4/D7/D3/D5/D6         * Restore stack
    RTS
ea_pattern_movem_d1:    * movem  (SP)+ , ---    ; D0 --> A7
    JSR     ea_ea_mode
    JSR     printComma
    JSR     ea_pattern_movem_count_1s   * Move # 1's to D6
    JSR     ea_pattern_movem_printRegs
    MOVEM.L (SP)+, D4/A4/D7/D3/D5/D6         * Restore stack
    RTS

* Reg Array loaded to A4.
* #1's loaded to D6  
* Bitmask loaded to D3
ea_pattern_movem_printRegs:
    MOVE.W  #15, D7     * Init loop counter
    MOVE.W  D3, D4      * Move reg mask to D4
ea_pattern_movem_printRegs_loop:
    BTST    #0, D4          * Is right most bit a 0?
    BEQ     ea_pattern_movem_pReg_0 * Skip printing
    MOVE.W  D7, D5      * Temp storage
    LSL.W   #1, D5      * multiply by two
    MOVE.W  (A4, D5.W), (A1)+
    JSR     printOutEaColor
    
    CMPI.W  #1, D6
    DBEQ    D6, ea_pattern_movem_pReg_slash * Is it the last one? Yes? Okay skip to pReg0
    BRA     ea_pattern_movem_pReg_0 * Skip the slash
ea_pattern_movem_pReg_slash:
    JSR     printSlash                  * Otherwise, print a slash and continue. 
ea_pattern_movem_pReg_0:
    ROR.W   #1, D4          * Keep rotating. 
    CMPI.W  #0, D7          * Is the counter equal to 0? 
    DBEQ    D7, ea_pattern_movem_printRegs_loop  ; Are we equal to 0? No? Alright keep looping.
    RTS
   
* We need to count total bits set to 1 so we can have the right # of slashes. "/" 
* D6 will contain the final count.
ea_pattern_movem_count_1s:  * Assume start with WORD of data in D3
    MOVE.W  D3, D4          * Move the reg mask to D4.
    MOVE.W  #15, D7         * Init the loop counter
    MOVE.W  #0, D6          * Init the 1's counter.
ea_pattern_movem_count_1s_loop:
    BTST    #0, D4          * Is right most bit a 0?
    BEQ     ea_pattern_movem_count_1s_0 * Don't bother incrementing counter if BTST is 0.
    ADDI.W  #1, D6          * We found a 1. Increment counter.
ea_pattern_movem_count_1s_0:
    ROR.W   #1, D4          * Keep rotating. 
    CMPI.W  #0, D7          * Is the counter less than 0? 
    DBEQ    D7, ea_pattern_movem_count_1s_loop  ; Are we equal to 0? No? Alright keep looping.
    RTS
    
*------------------------------------------------------------------------------
ea_pattern_and:
    MOVE.B  ADDR_OP_00C0, ADDR_EA_SIZE
    JSR     eaPrintSize
    MOVE.B  ADDR_OP_0100, D4
    CMP.B   #1, D4
    BEQ     ea_pattern_and_1
ea_pattern_and_0:   * <ea> -> Dn  
    JSR     ea_getLastSixModeAndXnBits
    JSR     ea_ea_mode
    JSR     printComma
    MOVE.B  ADDR_OP_0E00, ADDR_EA_XN
    JSR     eaPrintXnAsDn
    RTS
ea_pattern_and_1:   * Dn -> <ea>  
    MOVE.B  ADDR_OP_0E00, ADDR_EA_XN
    JSR     eaPrintXnAsDn
    JSR     printComma
    JSR     ea_getLastSixModeAndXnBits
    JSR     ea_ea_mode
    RTS



*-----------------------------------------------------------------------------
* Takes data stored in ADDR_EA_SIZE and prints to screen the size of the thing
eaPrintSize:
    CMP.B   #0, ADDR_EA_SIZE
    BEQ     eaPrintSize_Byte    
    CMP.B   #1, ADDR_EA_SIZE
    BEQ     eaPrintSize_Word   
    CMP.B   #2, ADDR_EA_SIZE
    BEQ     eaPrintSize_Long
    BRA     eaPrintSize_Invalid
eaPrintSize_Byte:
    JSR     printDotByte
    JSR     printTab
    RTS
eaPrintSize_Word:
    JSR     printDotWord
    JSR     printTab
    RTS
eaPrintSize_Long:
    JSR     printDotLong
    JSR     printTab
    RTS
eaPrintSize_Invalid:
    JSR     printDotUnknown
    JSR     printTab
    RTS



*-----------------------------------------------------------------------------
* Takes data stored in ADDR_EA_SIZE and skips ahead that much space in memory.
eaSkipSize:
    CMP.B   #0, ADDR_EA_SIZE
    BEQ     eaSkipSize_Byte    
    CMP.B   #1, ADDR_EA_SIZE
    BEQ     eaSkipSize_Word   
    CMP.B   #2, ADDR_EA_SIZE
    BEQ     eaSkipSize_Long
    BRA     eaSkipSize_Invalid
eaSkipSize_Byte:
    JSR     NEXT_WORD
    RTS
eaSkipSize_Word:
    JSR     NEXT_WORD
    RTS
eaSkipSize_Long:
    JSR     NEXT_LONG    
    RTS
eaSkipSize_Invalid:
    RTS
 

* -----------------------------------------------------------------------------
* Great for BRA, BSR, and Bcc.
* Just make sure the OPcode is in D3. Oh, and don't expect the OPcode to still
* be in D3 when this method returns. It might read further data. 
ea_ea_displacement:
    MOVE.L  A5, D6
    JSR     printTab
    JSR     printMoney
    CMP.B   #0, ADDR_OP_00FF          ; is 16 bit displacement?
    BEQ     ea_ea_displacement_16bit
    CMP.B   #$FF, ADDR_OP_00FF        ; is 32 bit displacement?
    BEQ     ea_ea_displacement_32bit
    MOVE.B  ADDR_OP_00FF, D5
    ADD.L   D6, D5
    JSR     APPEND_D5_BYTE
	JSR		printOutEaColor
    RTS
ea_ea_displacement_16bit:
    JSR     NEXT_WORD
    MOVE.W  D3, D5
    ADD.L   D6, D5
    JSR     APPEND_D5_WORD
	JSR		printOutEaColor
    RTS
ea_ea_displacement_32bit: 
    JSR     NEXT_LONG
    MOVE.L  D3, D5
    ADD.L   D6, D5
    JSR     APPEND_D5_LONG
	JSR		printOutEaColor
    RTS
   
* ---------------------------------------------------------
* Great for  ASd, LSd, ROXd, ROd
* 1110 ccc d ss m01 rrr
ea_pattern_rotation:
    MOVE.B  ADDR_OP_00C0, ADDR_EA_SIZE    ; Isolate last two bits for size
    JSR     eaPrintSize
    MOVE.L  D3, D4
    LSR.W   #5, D4              
    ANDI.W  #1, D4              ; Isolate that one bit (Mode)
    CMPI.W  #0, D4
    BEQ     ea_pattern_rotation_m0
    BRA     ea_pattern_rotation_m1
ea_pattern_rotation_m0:         ; M=0? 1-7, a 0 is converted to 8.     (immediate shift count)     
    JSR     printPound
    JSR     printMoney          ; Do we really need this?
    CMP.B   #0, ADDR_OP_0E00    ; If true, it's an 8, not 0
    BEQ     ea_pattern_rotation_m0_8
    MOVE.B  ADDR_OP_0E00, D5
    JSR     APPEND_D5_BYTE
	JSR		printOutEaColor
    BRA     ea_pattern_rotation_mX
ea_pattern_rotation_m0_8:
    MOVE.B  #8, D5
    JSR     APPEND_D5_BYTE
	JSR		printOutEaColor
    BRA     ea_pattern_rotation_mX
ea_pattern_rotation_m1:         ; M=1? data register specified contains the shift count (register shift count)
    MOVE.B  ADDR_OP_0E00, ADDR_EA_XN    ; 3 bits for count/register
    JSR     eaPrintXnAsDn       ; Print that data register
ea_pattern_rotation_mX:         ; next phase
    JSR     printComma           ; Isolate destination register
    MOVE.B  ADDR_OP_0007, ADDR_EA_XN
    JSR     eaPrintXnAsDn       ; Print that data register
    RTS   
* -----------------------------------------------------------------------------
ea_getLastSixModeAndXnBits:
    MOVE.B  ADDR_OP_0038, ADDR_EA_MODE
    MOVE.B  ADDR_OP_0007, ADDR_EA_XN
    RTS

eaPrintXnAsDn:
    MOVEM.L     D0-D7/A0/A2-A6, -(SP)   ; Save registers
    CLR         D4  
    MOVE.B      ADDR_EA_XN, D4
    LSL.W       #1, D4                  ; x2. two bytes per array index
    LEA         s_DnArray, A3           ; Load to A3 
    MOVE.W      (A3, D4.W), (A1)+       ; Move array index D4 to (A1), then increment.");
    JSR         printOutEaColor   
    MOVEM.L     (SP)+, D0-D7/A0/A2-A6    ; Restore registers
    RTS    

eaPrintXnAsAn:
    MOVEM.L     D0-D7/A0/A2-A6, -(SP)   ; Save registers
    CLR         D4  
    MOVE.B      ADDR_EA_XN, D4
    LSL.W       #1, D4                  ; x2. two bytes per array index
    LEA         s_AnArray, A3           ; Load to A3 
    MOVE.W      (A3, D4.W), (A1)+       ; Move array index D4 to (A1), then increment.");
    JSR         printOutEaColor  
    MOVEM.L     (SP)+, D0-D7/A0/A2-A6    ; Restore registers
    RTS    

eaFixSizeMovePattern:
    MOVE.B  ADDR_EA_SIZE, D4
    CMP.B   #1, D4
    BEQ     eaFixSizeMovePattern_byte
    CMP.B   #3, D4
    BEQ     eaFixSizeMovePattern_word
    CMP.B   #2, D4
    BEQ     eaFixSizeMovePattern_long
    BRA     eaFixSizeMovePattern_invalid
eaFixSizeMovePattern_byte: 
    MOVE.B  #0, ADDR_EA_SIZE 
    RTS
eaFixSizeMovePattern_word: 
    MOVE.B  #1, ADDR_EA_SIZE
    RTS
eaFixSizeMovePattern_long: 
    MOVE.B  #2, ADDR_EA_SIZE
    RTS
eaFixSizeMovePattern_invalid: 
    MOVE.B  #3, ADDR_EA_SIZE
    RTS
   
* -----------------------------------------------------------------------------

ea_data_reg:
    ; print Dn, or An
    RTS
    
    
* M111 Xn 100
ea_data_immediate:
    
    RTS

;ea_getSize1_arr:    DC.B
;ea_getSize1:    ; Like with ORI to CCR
;    MOVEM.L     D4, -(SP) 
;    MOVE.L      D3,D4
;    ROR.L       #7, D4
;    ANDI.L      #$00000002, D4
;    lea         ea_getSize1_arr, A3
;    JSR
    
*------ \d{10}(mmmXXX) Like in ORI to CCR
* D5 = size
* D6 = mode
* D7 = Xn
ea_pattern_1:
    ;MOVEM.L     D0-D2/D4-D7/A1-A4, -(SP)    
    ;JSR         printSize1
    ;ANDI.L      #$003, D4

    ; size, mode, register or whatever
    ;MOVEM.L     (SP)+, D0-D2/D4-D7/A1-A4
    RTS






















































*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
