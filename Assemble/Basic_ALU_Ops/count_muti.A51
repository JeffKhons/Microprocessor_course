ORG 0000H ; start from 0000H
MOV A, #032H ; move 032H into ACC
MOV B, #006H ; move 006H into B
SUBB A, B ; A-B, then save into ACC
MOV B, #007H ; move multiplier 007H into B
MUL AB ; AxB
END