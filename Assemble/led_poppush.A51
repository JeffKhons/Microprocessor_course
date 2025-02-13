            ORG 0000H
			JMP LOOP
            ORG 0030H
LOOP:       MOV SP, #32H ;SP = #32H
            MOV A, #0xfc ;A = #0xfc
            MOV P2, A ;P2 = A
            SETB P1.0 ;set p1.0 to high
			SETB P1.1 ;set p1.1 to high
			MOV R3, #0d ; set count
            CALL MARQUEE ;jump into marquee when p1.0 is low
            JMP LOOP ;infinite loop
MARQUEE:    CALL DEBOUNCE ;call DELAY
			RL A;
			MOV P2,A
			JNB P1.0 ,SCAN_PUSH;
			JNB P1.1 ,SCAN_POP;
            JMP MARQUEE
DEBOUNCE:   MOV R1, #250 ; move 250 times into R4
DE_250_ms:  MOV R2, #250 ; move 250 times into R3
            DJNZ R2, $ ; jump to itself R3 times
            DJNZ R1, DE_250_ms ; delay 25ms
            RET ; return to main code
SCAN_PUSH:  CALL DEBOUNCE
			MOV R0,A
			PUSH 00h
			INC R3
            JMP MARQUEE 			
SCAN_POP:   CALL DEBOUNCE
            POP 00h
			MOV P2,R0
            DJNZ R3,SCAN_POP
            MOV A,#0FFH
            MOV P2,A			
			END