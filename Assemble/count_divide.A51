ORG 0 ; start from 0000H
MOV A, #064H ; move 064H into ACC
MOV B, #00DH ; move 00DH into B
ADD A, B ; A+B, then save into ACC
MOV B, #006H ; move divisor 006H into B
DIV AB ; A/B
END