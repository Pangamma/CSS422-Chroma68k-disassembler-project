*------------------------------------------------------------------------------
* Program: IO section
* Description: Test data for all the codes
*------------------------------------------------------------------------------
TD_START: * LEA this to test it
test_ADDI.B:
        ADDI.B  #$AB,D1
        ADDI.B  #$CD,(A0)        
        ADDI.B  #$EF,(A0)+
        ADDI.B  #$09,-(A0)
        ADDI.B  #$0A,$00008200
        ADDI.B  #$0B,$00008100
        
test_ADDI.W:
        ADDI.W  #$00AB,D1
        ADDI.W  #$00CD,(A0)        
        ADDI.W  #$00EF,(A0)+
        ADDI.W  #$0009,-(A0)
        ADDI.W  #$000A,$00008200
        ADDI.W  #$000B,$00008100     

test_ADDI.L:
        ADDI.L  #$000000AB,D1
        ADDI.L  #$000000CD,(A0)        
        ADDI.L  #$000000EF,(A0)+
        ADDI.L  #$00000009,-(A0)
        ADDI.L  #$0000000A,$00008200
        ADDI.L  #$0000000B,$00008100 

test_EORI.B:
        EORI.B  #$AB,D1
        EORI.B  #$CD,(A0)        
        EORI.B  #$EF,(A0)+
        EORI.B  #$01,-(A0)    
        EORI.B  #$0A,$00008200
        EORI.B  #$0B,$00008100
        
test_CMPI.B:
        CMPI.B  #$AB,D1
        CMPI.B  #$CD,(A0)        
        CMPI.B  #$EF,(A0)+
        CMPI.B  #$01,-(A0)    
        CMPI.B  #$0A,$00008200
        CMPI.B  #$0B,$00008100                

test_BCHG_dynamic:
        BCHG.L  D0,D1
        BCHG.B  D0,(A0)
        BCHG.B  D0,(A0)+
        BCHG.B  D0,-(A0)
        BCHG.B  D0,$00008200
        BCHG.B  D0,$00008100        
               
test_BCHG_static:
        BCHG.L  #$000000AB,D1
        BCHG.B  #$CD,(A0)
        BCHG.B  #$EF,(A0)+
        BCHG.B  #$01,-(A0)
        BCHG.B  #$02,$00008200
        BCHG.B  #$03,$00008100  

test_LEA:
        LEA (A0),A1
        LEA $00008200,A1
        LEA $00008100,A1

test_CLR:
        CLR.L   D1
        CLR.L   (A0)
        CLR.L   (A0)+
        CLR.L   -(A0)
        CLR.L   $00008200
        CLR.L   $00008100

test_JSR:
        JSR (A0)
        JSR $00008200
        JSR $00008100

test_RTS:
         RTS     

test_SUBQ.B:
        SUBQ.B  #$01,D1
        SUBQ.W  #$0002,A0
        SUBQ.B  #$03,(A0)
        SUBQ.B  #$04,(A0)+
        SUBQ.B  #$05,-(A0)
        SUBQ.B  #$06,$8200
        SUBQ.B  #$07,$00008100
TD_STOP:
                    





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
