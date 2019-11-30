*-----------------------------------------------------------
* Title      : Main File
* Author : Taylor Love
* Description: Includes the other files for the program.
*-----------------------------------------------------------

    ORG $1000
MAIN_ORIGIN:

*------------  S E T T I N G S  -----------------------------------------------
IS_COLOR_ENABLED        equ 1   * Enable / Disable color output
IS_COOL_INTRO_ENABLED   equ 0   *
IS_COOL_EXIT_ENABLED    equ 0   *
IS_FILE_OUTPUT_ENABLED  equ 1   * Will print results to file if value is 1.
IS_TEST                 equ 1   * 
*------------------------------------------------------------------------------

MAIN:
    MOVEA.L #$00100000,SP                   ; set the location of the stack pointer. (A7/SS) This ensures we ALWAYS start fresh.
	JSR     RESET_OUT
	JSR     FILES_RESET                     * Ensure output file is reset for more output
    JSR	    SPLASH_PAGE			            * Show splash screen
    JSR     GET_START_AND_END_ADDRESSES     * Stores to A5 and A6. 
    JSR     OP_LOOP
    JSR     ASK_TO_GO_AGAIN                 * Output is at A5. 1 = go again.
    CMPA.L  #1, A5
    BEQ     MAIN
    JSR     SHOW_QUIT_MSG
    JSR     FILES_CLOSE_ALL
    JMP     STOP


*------------------------------------------------------------------------------
    ;--------------  I N T R O
    ifne IS_COOL_INTRO_ENABLED
    INCLUDE 'io_splash_cool.x68'        ; title splash screen with PNG graphics
    endc
    ifeq IS_COOL_INTRO_ENABLED
    INCLUDE 'io_splash_lame.x68'        ; title splash screen without PNG graphics
    endc


    ;--------------  I N P U T S
    ; collect address routines. "GET_START_AND_END_ADDRESSES"
    ifne IS_TEST
    INCLUDE 'io_address_inputs_test.x68'    ; Skip the prompt. Just grab data.  
    INCLUDE 'test_codes.x68'            ; Start at TD_START, end at TD_STOP. 
    endc
    ifeq IS_TEST    
    INCLUDE 'io_address_inputs.x68'         ; Get data by asking the user
    endc
    

    ;--------------  E X I T _ P R O M P T
    ; Prompt to retry. Also show quit message.  "ASK_TO_GO_AGAIN" && "SHOW_QUIT_MSG"
    ifne IS_COOL_EXIT_ENABLED
    INCLUDE 'io_ask_to_go_again_cool.x68'   ; splash retry page with PNG graphics
    endc
    ifeq IS_COOL_EXIT_ENABLED
    INCLUDE 'io_ask_to_go_again.x68'        ; splash retry page without PNG graphics
    endc

    
     ;-------------  O T H E R _ I N C L U D E S
    INCLUDE 'ea_main.x68'               ; Effective Address decoder
    INCLUDE 'op_loop.x68'               ; OPCODE decoder     
    INCLUDE 'equates.x68'               ; common variables/constants/reserved memory spaces
    INCLUDE 'io_util.x68'               ; print functions
    INCLUDE 'io_util_files.x68'         ; file manipulation functions that can be rendered in based on settings
    INCLUDE 'strings.x68'               ; String constants, message strings. Include this last, or else it sometimes messes with addressing.     
    


    
*------------------------------------------------------------------------------
    SIMHALT                             ; halt simulator


STOP:    
    END    MAIN_ORIGIN





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
