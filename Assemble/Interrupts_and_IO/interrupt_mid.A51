ORG 0 ; start from 0000H
         MOV DPTR, #TABLE ; DPTR point to TABLE
		 MOV R5,#2;
START:   MOV R0, #1 ; initialize typed signal
         MOV R1, #4 ; set 4 rows
         MOV R2, #11110111B ; scan first row
SCAN:    MOV A, R2 ; move R2 to A
         MOV P2, A ; input scanned signal
         JNB P2.7, NUMBERIN ; scan column 1
         INC R0 ; add #001H into R0
         JNB P2.6, NUMBERIN; scan column 2
         INC R0 ; add #001H into R0
         JNB P2.5, NUMBERIN ; scan column 3
         INC R0 ; add #001H into R0
		 JNB P2.4, KEYIN ; scan column 4
         RR A ; next row
         MOV R2, A ; move A to R2
         DJNZ R1, SCAN ; scan 4 rows
         SJMP START ; jump to scan keypad again
KEYIN:   CALL DEBOUNCE ; call debounce function
		 JNB P2.3, PLUS;
		 JNB P2.2, MINUS;
		 JNB P2.1, MUTI;
		 JNB P2.0, DIVI;
         SJMP START ; jump to scan keypad again
NUMBERIN: CALL DEBOUNCE
         MOV A,R0; get typed signal
		 DJNZ R5,NUM_ONE; store number one
         MOV R7,A;store number two
		 MOV R5,#2;
		 SJMP START ; jump to scan keypad again
NUM_ONE: MOV R6,A;
         SJMP START ; jump to scan keypad again
TABLE:   DB 00000011B ; display "0"
		 DB 11001111B ; display "1" 
		 DB 10100100B ; display "2"
		 DB 10110000B ; display "3"
		 DB 10011001B ; display "4"
		 DB 10010010B ; display "5"
		 DB 10000011B ; display "6"
		 DB 11011000B ; display "7"
		 DB 10000000B ; display "8"
		 DB 10010000B ; display "9"
PLUS:  MOV A,R6;
       MOV B,R7;
	   ADD A,B;
	   SJMP ONE_DISPLAY; display keyboard
MINUS: MOV A,R6;
       MOV B,R7;
	   SUBB A,B;
	   SJMP ONE_DISPLAY; display keyboard
MUTI:  MOV A,R6;
       MOV B,R7;
	   MUL AB;
	   SJMP ONE_DISPLAY; display keyboard
DIVI:  MOV A,R6;
       MOV B,R7;
	   DIV AB;
	   SJMP TWO_DISPLAY; display keyboard	 
ONE_DISPLAY: MOV B ,#10;
             DIV  AB;
			 JNZ TWO_DISPLAY; If A not equal 0 , jump to TWO_DISPLAY
			 SETB RS0
             MOV R1, #0EFH ; select LED C3
			 MOV P0,R1;input 4-digit segment
			 CLR RS0
			 MOV A,B;store B value
			 MOVC A,@A+DPTR;
			 CALL DEBOUNCE;
			 MOV P1,A;
			 SJMP START;
TWO_DISPLAY: SETB RS0
             MOV R1, #0DFH ; select LED C2
			 MOV P0,R1;input 4-digit segment
			 CLR RS0
			 MOVC A,@A+DPTR;			 
             MOV P1,A;
             CALL DEBOUNCE;
			 MOV A,B;
			 MOVC A,@A+DPTR;
			 MOV P1,A;
			 LJMP START
DEBOUNCE:  MOV R4, #255 ; move 250 times into R4
DE_255_ms: MOV R3, #255 ; move 250 times into R3
         DJNZ R3, $ ; jump to itself R3 times
         DJNZ R4, DE_255_ms ; delay 25.5ms
         RET ; return to main code			 
END