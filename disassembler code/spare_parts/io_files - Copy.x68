*--------------------------------------------------------------------
* Title       : io_files.x68
* Author      : Taylor Love
* Description : Helper methods for printing, reading, and using files
*---------------------------------------------------------------------
* https://acorn.huininga.nl/pub/projects/CiscOS/_emulators/EASy68Ksource/EASy68K_Help/fileio.htm
    ORG $1000
MAIN_ORIGIN:
    JSR     RESET_OUT
*------------  S E T T I N G S  -----------------------------------------------
IS_COLOR_ENABLED equ 1
IS_COOL_INTRO_ENABLED equ 0
IS_COOL_EXIT_ENABLED equ 0
IS_FILE_OUTPUT_ENABLED equ 1  ; Will print results to file if value is 1.
IS_TEST equ 1
*------------------------------------------------------------------------------

    MOVE.L  #5, D5
     MOVE.L  #7, D6
    SUB.L  D5, D6
    JSR FILES_TEST
    JMP STOP

* BEGIN MEMORY STORAGE SPACE AND VARIABLES
FILE_HANDLE_ID      DS.L    1
FILE_CURSOR_OFFSET  DS.L    1 
FILE_READ_BUFFER    DS.B    2048
CONSOLE_BUFFER    DS.B    512
FILE_NUM_BYTES_SIZE DS.B    4 
FILE_OUTPUT_PATH   DC.B    'output.txt',0
ERROR_MSG            DC.B    'Something went wrong',0
    
* FINISH MEMORY STORAGE SPACE AND VARIABLES


FILES_TEST:      
    JSR FILES_RESET
    JSR printSlash
    
    
    MOVE.B      #NULL, (A1)+
    MOVE.L      #ADDR_OUT, A1
    
    MOVEM.L     D0/D1, -(SP)        * Save registers
    MOVE.B      #14, D0
    TRAP        #15
    MOVEM.L     (SP)+,D0/D1         * Restore registers
    JSR         RESET_OUT
    RTS   

    
    
    
    ;JSR FILES_HANDLE_RESULT_READ_ONLY
    ;JSR FILES_WRITE
    
    
    ;JSR FILES_OPEN_EXISTING  
    ;JSR FILES_CLOSE_ALL


    ;JSR FILES_CLOSE_ALL
  
  
    ;
    ;JSR FILES_READ   

    
    RTS
    
 
* ------------  R E S E T  --------------------------------------------------------------------------------------------
* Deletes the file, then creates a new one in its place with the same file name.
FILES_RESET:
    MOVEM.L     D0/D1/A1, -(SP)           * Save registers 
    
    MOVE.L      #50, D0                     * close all files
    TRAP        #15
    MOVE.L      #0,    FILE_HANDLE_ID       * reset file handles
    MOVE.L      #0,    FILE_CURSOR_OFFSET   * reset file cursor offsets
    
    LEA         FILE_OUTPUT_PATH, A1    * (A1) null terminated file name.
    MOVE.L      #57, D0                 * delete file
    TRAP        #15
    
    MOVE.L      #52, D0                 * Open existing/new file.
    TRAP        #15
    MOVE.L      D1,    FILE_HANDLE_ID   * Post: D1.L contains the File-ID (FID).
    JSR         FILES_HANDLE_RESULT   
    MOVEM.L     (SP)+, D0/D1/A1         * Restore registers
    RTS
    
FILES_APPEND:     
    MOVEM.L     D0/D1/D2/D5/D6/A1, -(SP)    * Save registers 
  ;  LEA         FILE_OUTPUT_PATH, A1    * (A1) null terminated file name.
 ;   MOVE.L      #52, D0                 * Open existing/new file.
 ;   TRAP        #15
 ;   MOVE.L      D1,    FILE_HANDLE_ID   * Post: D1.L contains the File-ID (FID).

    MOVE.L      #ADDR_OUT, D5               * Save buffer start to D5
    MOVE.L      A1, D6                  
    SUB.L       D5, D6                      * Store NUM_BYTES to append to D6
    SUB.L       #1, D6                      * skip the null at the end tho
      
    MOVE.L   FILE_HANDLE_ID, D1             * File handle
    MOVE.L   FILE_CURSOR_OFFSET, D2         * File position
    MOVE.L   #55, D0
    TRAP     #15
   
    LEA      ADDR_OUT, A1                   * Starting read position in memory
    MOVE.L   D6, D2                         * Data size in bytes

    MOVE.L   #54, D0                        * Write data to file
    TRAP     #15
   
   
    MOVE.L   #50,D0                         * Close file so it can write properly
    TRAP   #15            
    MOVEM.L     (SP)+, D0/D1/D2/D5/D6/A1    * Restore registers
    RTS
   simhalt
   
    simhalt
     JSR         RESET_OUT
     RTS
* // WRITE D6 bytes to output file,
* // starting at  FILE_CURSOR_OFFSET
*// increment FILE_CURSOR_OFFSET = FILE_CURSOR_OFFSET + D6
 *   close file
    
    
;   lea    data,a1         data to write
 ;  move   #datasize,d2   # bytes to write
  ; move   #54,d0         write to file
  ; trap   #15

   
* ------------  W R I T E  --------------------------------------------------------------------------------------------
* Trap 54 - Write file. Like read file, except D2.L holds number of bytes to write (unaltered upon return).
FILES_WRITE
    MOVEM.L     D0/D1/D2/A1, -(SP)      * Save registers
    MOVE.L      FILE_HANDLE_ID, D1      * Load current file handle    
    MOVE.L      2, D2                * Max bytes to write
    MOVE.L      FILE_READ_BUFFER, A1    * Buffer address 
    MOVE.L      #54, D0                 * read file
    TRAP        #15     

   ; JSR         FILES_HANDLE_RESULT
    MOVE.L      D2, FILE_NUM_BYTES_SIZE * Save num bytes read
    MOVE.L      D2, FILE_CURSOR_OFFSET
    MOVEM.L     (SP)+, D0/D1/D2/A1       * Restore registers
    RTS
    



* ------------  D E L E T E  ------------------------------------------------------------------------------------------
* Trap 57.
FILES_DELETE:
    MOVEM.L     D0/A1, -(SP)            * Save registers
    LEA         FILE_OUTPUT_PATH, A1    * (A1) null terminated file name.
    MOVE.L      #57, D0                 * delete file
    TRAP        #15
    
    MOVEM.L     (SP)+, D0/A1       * Restore registers
    RTS
    


* ------------  R E A D  ----------------------------------------------------------------------------------------------
* Trap 57.
* Read file
*    Pre: File-ID in D1.L as returned from 51 or 52,
*           (A1) buffer address,
*           D2.L number of bytes to read.
*    Post: D2.L holds number of bytes actually read,
*    EOF may cause a shortened read.
FILES_READ:
    MOVEM.L     D0/D1/D2/A1, -(SP)      * Save registers
    MOVE.L      FILE_HANDLE_ID, D1      * Load current file handle    
    MOVE.L      2048, D2                * Max bytes to read
    MOVE.L      FILE_READ_BUFFER, A1    * Buffer address 
    MOVE.L      #53, D0                 * read file
    TRAP        #15     

    MOVE.L      D2, FILE_NUM_BYTES_SIZE * Save num bytes read
    MOVE.L      D2, FILE_CURSOR_OFFSET    
    CMP.L       #0, D0
    BEQ         FILES_READ_SUCCESS

    
    FILES_READ_SUCCESS:
    MOVEM.L     (SP)+, D0/D1/D2/A1       * Restore registers

    RTS
    
    
    
* ------------  C L O S E _ A L L  ------------------------------------------------------------------------------------
* Trap 50. - Close all files. It is recommended to use this at the start of any program using file handling.
FILES_CLOSE_ALL:
    MOVEM.L     D0, -(SP)           * Save registers
    MOVE.L      #50, D0             * close all files
    TRAP        #15
    MOVE.L      #0,    FILE_HANDLE_ID
    MOVE.L      #0,    FILE_CURSOR_OFFSET
    MOVEM.L     (SP)+, D0           * Restore registers
    RTS



* ------------  O P E N _ E X I S T I N G  ----------------------------------------------------------------------------
* Trap 51. - Open existing file. If not existing, it will be created.
FILES_OPEN_EXISTING:    
    MOVEM.L     D0/D1/A1, -(SP)         * Save registers
    LEA         FILE_OUTPUT_PATH, A1    * Pre: (A1) null terminated file name.
    MOVE.L      #51, D0                 * Open existing file. Blows up if file does not exist.
    TRAP        #15       
    JSR         FILES_HANDLE_RESULT    
    MOVE.L      D1,    FILE_HANDLE_ID   * Post: D1.L contains the File-ID (FID).
    MOVEM.L     (SP)+, D0/D1/A1         * Restore registers
    RTS
    
    
    
* ------------  O P E N _ N E W  --------------------------------------------------------------------------------------
* Trap 52. - Open existing file. If not existing, it will be created.
* Open existing or new file. If no file exists, it will be created.
*     Pre: (A1) null terminated file name.
*     
FILES_OPEN_NEW:
    MOVEM.L     D0/D1/A1, -(SP)         * Save registers
    LEA         FILE_OUTPUT_PATH, A1    * Pre: (A1) null terminated file name.
    MOVE.L      #52, D0                 * Open existing/new file.
    TRAP        #15
    JSR         FILES_HANDLE_RESULT    
    MOVE.L      D1,    FILE_HANDLE_ID   * Post: D1.L contains the File-ID (FID).
    MOVEM.L     (SP)+, D0/D1/A1         * Restore registers
    RTS
    
    
FILES_HANDLE_RESULT:
    CMP.L       #0, D0              * Success               
    BNE         FILES_HANDLE_RESULT_EOF
    RTS
    
FILES_HANDLE_RESULT_EOF:    
    JSR RESET_OUT
    CMP.L       #1, D0              * EOF encountered            
    BNE         FILES_HANDLE_RESULT_ERROR
    MOVE.L      #'EOF', (A1)+
    JSR PRINT_OUT
    RTS
    
    
FILES_HANDLE_RESULT_ERROR:    
    CMP.L       #2, D0              * Error      
    BNE         FILES_HANDLE_RESULT_READ_ONLY   
    MOVE.L      #'ERR', (A1)+   
    JSR PRINT_OUT
    RTS
    
FILES_HANDLE_RESULT_READ_ONLY:    
    CMP.L       #3, D0              * Read only (Tasks 51 & 59 only)    
    MOVE.L      #'CANN', (A1)+     
    MOVE.L      #'OT R', (A1)+ 
    MOVE.L      #'EAD', (A1)+
    JSR PRINT_OUT
    RTS

PRINT_OUT2:
    MOVE.L      #NULL, (A1)+
    MOVE.L      #CONSOLE_BUFFER, A1

    
    MOVEM.L     D0/D1, -(SP)        * Save registers    
    JSR FILES_WRITE
    MOVE.B      #14, D0
    TRAP        #15
    MOVEM.L     (SP)+,D0/D1         * Restore registers
    JSR         RESET_OUT
    RTS   
RESET_OUT2:
    MOVE.L      #CONSOLE_BUFFER, A1
    RTS

    
    
    SIMHALT                             ; halt simulator

    INCLUDE 'io_util.x68'               ; print functions
    INCLUDE 'equates.x68'               ; common variables/constants/reserved memory spaces
    INCLUDE 'strings.x68'               ; String constants, message strings. Include this last, or else it sometimes messes with addressing.    
    
    

STOP:
    END    MAIN_ORIGIN





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
