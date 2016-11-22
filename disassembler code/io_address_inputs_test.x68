*------------------------------------------------------------------------------
* Program: IO section
* Written by: Taylor Love
* Date: September 10th, 2015
* Description: Has methods for printing and reading from and to the console.
*------------------------------------------------------------------------------

* This is actually a subroutine. It gathers the start and end addr into A5, and A6
* respectively. 
GET_START_AND_END_ADDRESSES:
    ;MOVE.L  #$1000, A5
    ;MOVE.L  #$1256, A6
    LEA TD_START, A5
    LEA TD_STOP, A6
    RTS






*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
