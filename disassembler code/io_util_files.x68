*--------------------------------------------------------------------
* Title       : io_util_files.x68
* Author      : Taylor Love
* Description : Helper methods for printing, reading, and using files
*---------------------------------------------------------------------
* https://acorn.huininga.nl/pub/projects/CiscOS/_emulators/EASy68Ksource/EASy68K_Help/fileio.htm
 
 ifne IS_FILE_OUTPUT_ENABLED
* BEGIN MEMORY STORAGE SPACE AND VARIABLES
FILE_HANDLE_ID      DS.L    1
FILE_CURSOR_OFFSET  DS.L    1 
FILE_READ_BUFFER    DS.B    2048
FILE_NUM_BYTES_SIZE DS.B    4 
IS_FILE_OUTPUT_SUSPENDED     DS.L 1     * For when we don't want to print to output
FILE_OUTPUT_PATH    DC.W    'output.txt',0    
* FINISH MEMORY STORAGE SPACE AND VARIABLES
 endc

 
* ------------  R E S E T  --------------------------------------------------------------------------------------------
* Deletes the file, then creates a new one in its place with the same file name.
FILES_RESET:
    ifne IS_FILE_OUTPUT_ENABLED
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
    MOVEM.L     (SP)+, D0/D1/A1         * Restore registers
    endc
    RTS
    
FILES_SUSPEND_OUTPUT:
    ifne IS_FILE_OUTPUT_ENABLED
    MOVE.L  #1, IS_FILE_OUTPUT_SUSPENDED
    endc
    RTS
    
FILES_RESUME_OUTPUT:
    ifne IS_FILE_OUTPUT_ENABLED
    MOVE.L  #0, IS_FILE_OUTPUT_SUSPENDED
    endc
    RTS
  
FILES_APPEND: 
    ifne IS_FILE_OUTPUT_ENABLED
    CMP.L   #1, IS_FILE_OUTPUT_SUSPENDED
    BNE     FILES_APPEND_NotSuspended
    RTS
FILES_APPEND_NotSuspended: 
    MOVEM.L     D0/D1/D2/D4/D5/D6, -(SP)    * Save registers 
    JSR         FILES_OPEN_EXISTING

    MOVE.L      #ADDR_OUT, D5               * Save buffer start to D5
    MOVE.L      A1, D6                  
    SUB.L       D5, D6                      * Store NUM_BYTES to append to D6
    SUB.L       #1, D6                      * skip the null at the end tho
      
    MOVE.L      FILE_HANDLE_ID, D1          * File handle
    MOVE.L      FILE_CURSOR_OFFSET, D2      * File position
    MOVE.L      #55, D0
    TRAP        #15
    
    MOVE.L      FILE_CURSOR_OFFSET, D4      * Save offset + length to offset
    ADD.L       D6, D4                     
    MOVE.L      D4, FILE_CURSOR_OFFSET
     
    
    MOVEM.L     A1, -(SP)                   * Save A1
    LEA         ADDR_OUT, A1                * Starting read position in memory
    MOVE.L      D6, D2                      * Data size in bytes

    MOVE.L      #54, D0                     * Write data to file
    TRAP        #15
       
    JSR         FILES_CLOSE                 * Close file so it can write properly
    
    MOVEM.L     (SP)+, A1                   * Save A1
    MOVEM.L     (SP)+, D0/D1/D2/D4/D5/D6    * Restore registers
    endc
    RTS


   
* ------------  W R I T E  --------------------------------------------------------------------------------------------
* Trap 54 - Write file. Like read file, except D2.L holds number of bytes to write (unaltered upon return).
FILES_WRITE:
    ifne IS_FILE_OUTPUT_ENABLED
    MOVEM.L     D0/D1/D2/A1, -(SP)      * Save registers
    MOVE.L      FILE_HANDLE_ID, D1      * Load current file handle    
    MOVE.L      2, D2                * Max bytes to write
    MOVE.L      FILE_READ_BUFFER, A1    * Buffer address 
    MOVE.L      #54, D0                 * read file
    TRAP        #15     


    MOVE.L      D2, FILE_NUM_BYTES_SIZE * Save num bytes read
    MOVE.L      D2, FILE_CURSOR_OFFSET
    MOVEM.L     (SP)+, D0/D1/D2/A1       * Restore registers
    endc
    RTS
    



* ------------  D E L E T E  ------------------------------------------------------------------------------------------
* Trap 57.
FILES_DELETE:
    ifne IS_FILE_OUTPUT_ENABLED
    MOVEM.L     D0/A1, -(SP)            * Save registers
    LEA         FILE_OUTPUT_PATH, A1    * (A1) null terminated file name.
    MOVE.L      #57, D0                 * delete file
    TRAP        #15
    MOVEM.L     (SP)+, D0/A1       * Restore registers
    endc
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
    ifne IS_FILE_OUTPUT_ENABLED
    MOVEM.L     D0/D1/D2/A1, -(SP)      * Save registers
    MOVE.L      FILE_HANDLE_ID, D1      * Load current file handle    
    MOVE.L      2048, D2                * Max bytes to read
    MOVE.L      FILE_READ_BUFFER, A1    * Buffer address 
    MOVE.L      #53, D0                 * read file
    TRAP        #15     

    MOVE.L      D2, FILE_NUM_BYTES_SIZE * Save num bytes read
    MOVE.L      D2, FILE_CURSOR_OFFSET
    MOVEM.L     (SP)+, D0/D1/D2/A1       * Restore register
    endc
    RTS
    
    
    
* ------------  C L O S E _ A L L  ------------------------------------------------------------------------------------
* Trap 50. - Close all files. It is recommended to use this at the start of any program using file handling.
FILES_CLOSE_ALL:
    ifne IS_FILE_OUTPUT_ENABLED
    MOVEM.L     D0, -(SP)           * Save registers
    MOVE.L      #50, D0             * close all files
    TRAP        #15
    MOVE.L      #0,    FILE_HANDLE_ID
    MOVE.L      #0,    FILE_CURSOR_OFFSET
    MOVEM.L     (SP)+, D0           * Restore registers
    endc
    RTS
    
* ------------  C L O S E  --------------------------------------------------------------------------------------------
* Trap 56. - Close current files. 
FILES_CLOSE:
    ifne IS_FILE_OUTPUT_ENABLED
    MOVEM.L     D0/D1, -(SP)        * Save registers
    MOVE.L      #56, D0             * Close current file
    MOVE.L      FILE_HANDLE_ID, D1 
    
    TRAP        #15
    MOVE.L      #0,    FILE_HANDLE_ID
    MOVEM.L     (SP)+, D0/D1        * Restore registers
    endc
    RTS



* ------------  O P E N _ E X I S T I N G  ----------------------------------------------------------------------------
* Trap 51. - Open existing file. If not existing, it will be created.
FILES_OPEN_EXISTING:    
    ifne IS_FILE_OUTPUT_ENABLED
    MOVEM.L     D0/D1/A1, -(SP)         * Save registers
    LEA         FILE_OUTPUT_PATH, A1    * Pre: (A1) null terminated file name.
    MOVE.L      #51, D0                 * Open existing file. Blows up if file does not exist.
    TRAP        #15       

    MOVE.L      D1,    FILE_HANDLE_ID   * Post: D1.L contains the File-ID (FID).
    MOVEM.L     (SP)+, D0/D1/A1         * Restore registers
    endc
    RTS
    
    
    
* ------------  O P E N _ N E W  --------------------------------------------------------------------------------------
* Trap 52. - Open existing file. If not existing, it will be created.
* Open existing or new file. If no file exists, it will be created.
*     Pre: (A1) null terminated file name.
*     
FILES_OPEN_NEW:
    ifne IS_FILE_OUTPUT_ENABLED
    MOVEM.L     D0/D1/A1, -(SP)         * Save registers
    LEA         FILE_OUTPUT_PATH, A1    * Pre: (A1) null terminated file name.
    MOVE.L      #52, D0                 * Open existing/new file.
    TRAP        #15

    MOVE.L      D1,    FILE_HANDLE_ID   * Post: D1.L contains the File-ID (FID).
    MOVEM.L     (SP)+, D0/D1/A1         * Restore registers
    endc
    RTS




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
