ORG 0 ; start from 0000H
MOV A, #10111101B ; move 10111101B into ACC
ANL A, #11101111B ; use AND Gate to turn Bit 4 into 0
MOV B, A ; move the value into B
MOV A, #01000010B ; move 01000010B into ACC
ORL A, #00010000B ; use OR Gate to turn Bit 4 into 1
CPL A ; use NOT Gate
END