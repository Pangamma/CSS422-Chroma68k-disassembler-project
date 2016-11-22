OP_LOOP:
    MOVE.L  #NUM_WIN_LINES, A4
OP_LOOP_POST_INIT:
    JSR     RESET_OUT               ; <PrintCurrentAddr>
    MOVE.L  A5, D5
    JSR     APPEND_D5_LONG
    JSR     printOutAddrColor           
    JSR     printTab                ; </PrintCurrentAddr>

    JSR     NEXT_WORD               ; Read next word into D3
    JSR     AnalyzeCurrentWord      ; Perform masks, split into stored data
    JSR     DetermineOpCode         ; Do opcode branching
    
    JSR     printNewLine            ; next line prepare to loop
    CMPA.L  A6, A5                  ; Are we outside our memory bounds?
    BGT     OP_LOOP_QUIT            ; Exit Loop if finished
    
    SUBA.W  #1, A4                  ; Decrement A4 num lines counter. (Consider making this memory storage instead of address register)
    CMP.W   #0, A4
    BGT     OP_LOOP_POST_INIT       ; If counter is 0 or lower, loop right away.
    MOVE.W  #NUM_WIN_LINES,A4	
    LEA     opLoop_enterToContinue ,A3
    JSR     APPEND_A3
    JSR     printOutPromptColor
    
    * Pause till "enter"
    MOVE.L      #ADDR_OUT, A1           * Move A1 pointer to safe spot, then overwrite it
    MOVE.L      #2, D0
    TRAP        #15                     * Contents stored in A1. Pray they don't enter in a mega string.
    ;MOVE.L      #ZERO_ADDR, (A1)        * Reset it so A1 is zeroed out.
   
    ;MOVE.W  #$FF00,D1           * Clear output
    ;MOVE    #11,D0  
    ;TRAP    #15

    JMP     OP_LOOP_POST_INIT  
OP_LOOP_QUIT:
    RTS
    INCLUDE 'op_determine.x68'        ; Contains DetermineOpCode subroutine.
    
*------------------------------------------------------------------------------
* AnalyzeCurrentWord: Subroutine
* Uses contents of D3 to populate known OP memory spaces with masked values
* from the opword that could be useful at a later time. We do this in one place
* because it saves space for later. To find the address locations, see the 
* equates file. 
AnalyzeCurrentWord:

    MOVE.W  D3, ADDR_OP_FFFF        ; The entire opword
    
    MOVE.L  D3, D4
    ANDI.W  #$F000, D4
    ROL.W   #4, D4
    MOVE.B  D4, ADDR_OP_F000        ; First 4
    
    ANDI.W  #$0003, D4
    MOVE.B  D4, ADDR_OP_3000        ; Size for MOVE codes
    
    MOVE.L  D3, D4
    ANDI.W  #$01C0, D4
    ROR.W   #6, D4
    MOVE.B  D4, ADDR_OP_01C0        ; Mode (early version)


    MOVE.L  D3, D4
    ANDI.W  #$0E00, D4
    ROL.W   #7, D4
    MOVE.B  D4, ADDR_OP_0E00        ; Xn

    MOVE.L  D3, D4
    ANDI.W  #$00C0, D4
    ROR.W   #6, D4
    MOVE.B  D4, ADDR_OP_00C0        ; S
    
    ANDI.B  #1, D4
    MOVE.B  D4, ADDR_OP_0040        ; Size for movem
    
    MOVE.L  D3, D4
    ANDI.W  #$0038, D4
    ROR.W   #3, D4
    MOVE.B  D4, ADDR_OP_0038        ; M

    MOVE.L  D3, D4
    ANDI.W  #$0F00, D4
    ROL.W   #8, D4
    MOVE.B  D4, ADDR_OP_0F00        ; Condition Code

    MOVE.L  D3, D4
    ANDI.W  #$0100, D4
    ROL.W   #8, D4
    MOVE.B  D4, ADDR_OP_0100        ; Direction/ Size

    MOVE.L  D3, D4
    ANDI.W  #$00FF, D4
    MOVE.B  D4, ADDR_OP_00FF        ; Displacement/ Data
    
    ANDI.W  #$003F, D4
    MOVE.B  D4, ADDR_OP_003F        ; Xn + M  
    
    ANDI.W  #$0007, D4
    MOVE.B  D4, ADDR_OP_0007        ; Xn
    
    MOVE.L  D3, D4
    ANDI.W  #$0400, D4
    ROL.W   #6, D4
    MOVE.B  D4, ADDR_OP_0400

    RTS






















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
