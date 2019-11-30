*   Title: Equates File
*   Description: Contains all the equates for the project. 
*   It also contains data storage spaces. 
*   Author: Taylor Love


ADDR_MIN    EQU     $00007000       ; minimum not yet implemented
ADDR_MAX    EQU     $00FFFFF0       ; maximum not yet implemented
ADDR_OUT    DS.B     1024           * Used in printing. Maximum 1024 bytes, starting at the label
NUM_WIN_LINES   EQU 31              ; Number of lines in a window. 


NULL    EQU     $00     NULL (End of line)
CR      EQU     $0D     Carriage Return
LF      EQU     $0A     New line (line feed)
NL      EQU     $0A     New line (line feed)
FF      EQU     $0C     Form Feed (Always end printing with a Form Feed.)
BS      EQU     $08     BACKSPACE
TAB     EQU     $09     TAB
SP      EQU     $20     SPACE
DEL     EQU     $7F     DELETE
CRNL    EQU     $0D0A   CR then NL




; M E M O R Y _ S T O R A G E _ S P A C E S (make sure you have even # of bytes)
ADDR_EA_SIZE    DS.B  1   ;  1 byte for size (S)
ADDR_EA_MODE    DS.B  1   ;  1 byte for mode  (M)
ADDR_EA_XN      DS.B  1   ;  1 byte for register (Xn) 
ADDR_OP_F000    DS.B    1   ; first four

ADDR_OP_0E00    DS.B    1   ; Dn/Xn/rotation
ADDR_OP_00C0    DS.B    1   ; size is kept here (ORI)
ADDR_OP_3000    DS.B    1   ; size is kept here (MOVE)
ADDR_OP_0038    DS.B    1   ; M


ADDR_OP_01C0    DS.B    1   ; M (early version)
ADDR_OP_0007    DS.B    1   ; Xn
ADDR_OP_0F00    DS.B    1   ; Condition code
ADDR_OP_0100    DS.B    1   ; Direction/Size

ADDR_OP_00FF    DS.B    1   ; Displacement/data
ADDR_OP_003F    DS.B    1   ; M + XN
ADDR_OP_0400    DS.B    1   ; Direction bit for MOVEM
ADDR_OP_0040    DS.B    1   ; Size for MOVEM

ADDR_OP_FFFF    DS.B    2   ; The current OPWord, basically.
ADDR_Plchldr    DS.B    2   ; Useless data because it makes my blocks of 4 pattern look good
;ADDR_IO_ADDR    DS.B    4   ; Current address at start of opword.
















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
