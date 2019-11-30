*-----------------------------------------------------------
* Title      : Main File
* Author : Taylor Love
* Description: Includes the other files for the program.
*-----------------------------------------------------------
; TODO: Use CLR because it is faster than "MOVE.L    #$0, Dn"
    ORG $1000

MAIN:
    MOVEA.L #$00100000,SP                   ; set the location of the stack pointer. (A7/SS) This ensures we ALWAYS start fresh.
	JSR     RESET_OUT
    JSR	    SPLASH_PAGE			            * Show splash screen
    JSR     GET_START_AND_END_ADDRESSES     * Stores to A5 and A6. 
    
    JSR     OP_LOOP
    
    JSR     ASK_TO_GO_AGAIN                 * Output is at A5. 1 = go again.
    CMPA.L  #1, A5
    BEQ     MAIN
    JSR     SHOW_QUIT_MSG
    JMP     STOP
    
    
*------------------------------------------------------------------------------
    INCLUDE 'ea_main.x68'               ; Effective Address decoder
    INCLUDE 'op_loop.x68'               ; OPCODE decoder  
    INCLUDE 'io_splash_cool.x68'        ; title splash screen.
    INCLUDE 'io_address_inputs.x68'     ; collect address routines. "GET_START_AND_END_ADDRESSES"
    INCLUDE 'equates.x68'               ; common variables/constants/reserved memory spaces    
    INCLUDE 'io_ask_to_go_again_cool.x68'    ; Prompt to retry. Also show quit message.  "ASK_TO_GO_AGAIN" && "SHOW_QUIT_MSG"
    INCLUDE 'io_util.x68'               ; print functions
    INCLUDE 'TestData.x68'              ; Start at TD_START, end at TD_STOP. 
    INCLUDE 'strings.x68'               ; String constants, message strings. Include this last, or else it sometimes messes with addressing.
    SIMHALT                             ; halt simulator

STOP:
    END    MAIN




































































*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
