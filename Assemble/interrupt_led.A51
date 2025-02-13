            ORG 00H ; code start from 000h
            SJMP MAIN ; jump to MAIN
            ORG 03H ; vector address for INT0
            SJMP INT0_ISR ; jump to INT0_ISR
            ORG 013H ;after vector table space
			SJMP INT1_ISR ; jump to INT0_ISR
            ORG 030H ;after vector table space
MAIN:       MOV IE, #10000101B ; enable EA and EX0 and EX1
			SETB IT0 ;set p3.2 to high
			SETB IT1 ;set p3.3 to high
			SETB IP.2 ; priority
			MOV SP, #30H ; stack start from #30H
            MOV A, #00000000B ; set ACC as 0000000B
LOOP:       MOV P2, A ; P1 = A(LED output)
            CALL DELAY ; call delay function
            CPL A ; reverse A
            SJMP LOOP ; infinite loop
INT0_ISR:   PUSH PSW ; push PSW into stack
            PUSH ACC ; push ACC into stack
            SETB RS0 ; switch to RB1
            MOV A, #11110000B ; set ACC as 11111110B
            MOV R0,#24 ; loop counter = 24
            CALL ROTATE_L ; left led
            POP ACC ; pop out ACC from stack
            POP PSW ; pop out PSW from stack
            RETI ; return from ISR
INT1_ISR:   PUSH PSW ; push PSW into stack
            PUSH ACC ; push ACC into stack
            SETB RS1 ; switch to RB2
			MOV A, #11111110B
			MOV R0,#16
			CALL ROTATE_L ; left led
			POP ACC ; pop out ACC from stack
            POP PSW ; pop out PSW from stack
            RETI ; return from ISR
ROTATE_L:   MOV P2, A ; P1 = A(LED output)
            CALL DELAY ; call delay function
            RL A ; rotate left
            DJNZ R0, ROTATE_L ; loop until R0 is 0
DELAY:      MOV R7, #200
D1:         MOV R6, #250
            DJNZ R6, $
            DJNZ R7, D1
            RET ; return
            END ; end the code
