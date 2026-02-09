			ORG 00H ; start address is 00H
			SJMP START_000
DISPLAY_759:MOV DPTR, #TABLE_759
            MOV R0, #3
			MOV R1, #0 ; table index
			MOV R2, #07FH ; LED drive pin(c0~c3) 
LOOP_1:		MOV P0, R2 ; select LED
			MOV A, R1; table index ; move R5 to A
			MOVC A, @A+DPTR ; get value from table
			MOV P1, A ; move value to P1
			CALL DEBOUNCE ; delay 0.5 ms
			INC R1 ; increase R1
            MOV A, R2 ; move R2 to A
            RR A ; rotate A
            MOV R2, A ; move A back to R2
			DJNZ R0,LOOP_1;
            SJMP DISPLAY_759;
TIMEBACK:   MOV R3, #01111111B ;
			MOV A,R3
			MOV P0,A
			CALL DEBOUNCE;
TIMEBACK_1: MOV A,R0
            MOVC A, @A+DPTR ; get signal from TABLE
			MOV P1, A ; output displayed signaL
			CALL DEBOUNCE;
			DJNZ R0,TIMEBACK_1
			MOV A,R0
            MOVC A, @A+DPTR ; get signal from TABLE
			MOV P1, A ; output displayed signal
			SJMP START
START_000: 	MOV R0, #3 ; 3 LED
			MOV R2, #08FH ; LED drive pin(c0~c3) 
LOOP: 		MOV P0, R2 ; select LED
			MOV A, R1 ; move R1 to A
			MOV DPTR, #TABLE_000 ; DPTR point to TABLE
			MOVC A, @A+DPTR ; get value from table
			MOV P1, A ; move value to P1
			CALL DEBOUNCE ; delay 0.5 ms
			SJMP START
START:      MOV DPTR, #TABLE
            MOV R0, #1 ; initialize typed signal
            MOV R1, #4 ; set 4 rows
            MOV R2, #11110111B ; scan first row
SCAN1:   	MOV A, R2 ; move R2 to A
			MOV P2, A ; input scanned signal
			JNB P2.7, NUMBERIN_1 ; scan column 1
			INC R0 ; add #001H into R0
			JNB P2.6, NUMBERIN; scan column 2
			INC R0 ; add #001H into R0
			JNB P2.5, NUMBERIN_3 ; scan column 3
			INC R0 ; add #001H into R0
			JNB P2.4, KEYIN ; scan column 4
			RR A ; next row
			MOV R2, A ; move A to R2
			DJNZ R1, SCAN1 ; scan 4 rows
			SJMP START ; jump to scan keypad again
NUMBERIN:	CALL DEBOUNCE
			MOV A,R0; get typed signal
			MOV R6,A;  store number 1
			SJMP START
NUMBERIN_1: JNB P2.3, NUMBERIN;
		    JNB P2.2, NUMBERIN;
		    JNB P2.1, NUMBERIN;
		    JNB P2.0, TIMEBACK;
NUMBERIN_3: JNB P2.3, NUMBERIN;
		    JNB P2.2, NUMBERIN;
		    JNB P2.1, NUMBERIN;
		    JNB P2.0, DISPLAY_759;
SCAN2:   	MOV R0, #1 ; initialize typed signal
			MOV R1, #3 ; set 4 rows
			MOV R2, #11110111B ; scan first row
			MOV A, R2 ; move R2 to A
SCAN2_1: 	MOV P2, A ; input scanned signal
			JNB P2.7, PLUS_1 ; scan column 1
			INC R0 ; add #001H into R0
			JNB P2.6, PLUS_1; scan column 2
			INC R0 ; add #001H into R0
			JNB P2.5, PLUS_1 ; scan column 3
			INC R0 ; add #001H into R0
			RR A ; next row
			MOV R2, A ; move A to R2
			DJNZ R1, SCAN2_1 ; scan 4 rows
			SJMP SCAN2 ; jump to scan keypad again
SCAN3:   	MOV R0, #1 ; initialize typed signal
			MOV R1, #3 ; set 3 rows
			MOV R2, #11110111B ; scan first row
SCAN3_1: MOV A, R2 ; move R2 to A
         MOV P2, A ; input scanned signal
         JNB P2.7, MINUS_1 ; scan column 1
         INC R0 ; add #001H into R0
         JNB P2.6, MINUS_1; scan column 2
         INC R0 ; add #001H into R0
         JNB P2.5, MINUS_1 ; scan column 3
         INC R0 ; add #001H into R0
         RR A ; next row
         MOV R2, A ; move A to R2
         DJNZ R1, SCAN3_1 ; scan 4 rows
         SJMP SCAN3 ; jump to scan keypad again
SCAN4:   MOV R0, #1 ; initialize typed signal
         MOV R1, #3 ; set 4 rows
         MOV R2, #11110111B ; scan first row
SCAN4_1: MOV A, R2 ; move R2 to A
         MOV P2, A ; input scanned signal
         JNB P2.7, MUTI_1 ; scan column 1
         INC R0 ; add #001H into R0
         JNB P2.6, MUTI_1; scan column 2
         INC R0 ; add #001H into R0
         JNB P2.5, MUTI_1 ; scan column 3
         INC R0 ; add #001H into R0
         RR A ; next row
         MOV R2, A ; move A to R2
         DJNZ R1, SCAN4_1 ; scan 4 rows
         SJMP SCAN4 ; jump to scan keypad again
KEYIN:   JNB P2.3, PLUS;
		 JNB P2.2, MINUS;
		 JNB P2.1, MUTI;
		 JNB P2.0, DIVI;
		 LJMP SCAN2
SCAN5:   MOV R0, #1 ; initialize typed signal
         MOV R1, #3 ; set 4 rows
         MOV R2, #11110111B ; scan first row
SCAN5_1: MOV A, R2 ; move R2 to A
         MOV P2, A ; input scanned signal
         JNB P2.7, DIVI_1 ; scan column 1
         INC R0 ; add #001H into R0
         JNB P2.6, DIVI_1; scan column 2
         INC R0 ; add #001H into R0
         JNB P2.5, DIVI_1 ; scan column 3
         INC R0 ; add #001H into R0
         RR A ; next row
         MOV R2, A ; move A to R2
         DJNZ R1, SCAN5_1 ; scan 4 rows
         SJMP SCAN5 ; jump to scan keypad again
PLUS:    CALL SCAN2
PLUS_1:  MOV A,R0;
         MOV R7,A;
		 MOV B,R7;
		 MOV A,R6;
	     ADD A,B;
	     SJMP DISPLAY; display keyboard
MINUS:   CALL SCAN3
MINUS_1: MOV A,R0;
         MOV R7,A;
		 MOV B,R7;
         MOV A,R6;        
	     SUBB A,B;
	     SJMP DISPLAY; display keyboard	 
DIVI:    CALL SCAN5
DIVI_1:  MOV A,R0;
         MOV R7,A;
		 MOV B,R7;
		 MOV A,R6;
	     DIV AB;
	     SJMP DISPLAY_DVDI; display keyboard
MUTI:    CALL SCAN4
MUTI_1:  MOV A,R0;
         MOV R7,A;
		 MOV B,R7;
		 MOV A,R6;
	     MUL AB;
	     SJMP DISPLAY; display keyboard
DISPLAY: CALL DEBOUNCE;
         MOV R0, #07FH ; select LED C0
	     MOV P0,R0;input 4-digit segment		 
		 MOVC A,@A+DPTR;
		 MOV P1,A
		 LJMP START;
DISPLAY_DVDI: CALL DEBOUNCE;
         MOV R0, #07FH ; select LED C0
	     MOV P0,R0;input 4-digit segment
		 MOVC A,@A+DPTR;
		 LJMP START;
         RET
DEBOUNCE: 	MOV R4, #250 ; move 250 times into R4
DE_250_us:  MOV R3, #250 ; move 250 times into R3
			RET ; return from subroutine
TABLE_000:  DB 11000000B ; display "0"
            DB 11000000B ; display "0"
            DB 11000000B ; display "0"
            DB 11000000B ; display "0"
            DB 11000000B ; display "0"
            DB 11000000B ; display "0"				
TABLE:		DB 11000000B ; display "0"
            DB 11001111B ; display "1" 
		    DB 10100100B ; display "2"
		    DB 10110000B ; display "3"
		    DB 10011001B ; display "4"
		    DB 10010010B ; display "5"
		    DB 10000011B ; display "6"
		    DB 11011000B ; display "7"
		    DB 10000000B ; display "8"
		    DB 10010000B ; display "9"
TABLE_759:  DB 11011000B ; display "7"
	        DB 10010010B ; display "5"
			DB 10010000B ; display "9"
END ; end of program