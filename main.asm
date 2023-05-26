RS equ P3.0
E equ P3.1

ORG 00h

main:
    ACALL init
    ACALL write_name
    ACALL write_surname
    SJMP main

init:
    MOV P1, #38h
    ACALL cmd
    MOV P1, #0Fh
    ACALL cmd
    MOV P1, #01h
    ACALL cmd
    MOV P1, #06h
    ACALL cmd
    RET

write_name:
    MOV DPTR, #NombreStr
aca: 
    CLR A
    MOVC A, @A+DPTR
    CJNE A, #0, next_character
    SJMP end_name
next_character:
    MOV P1, A
    ACALL display
    INC DPTR
    SJMP aca
end_name:
    RET

write_surname:
    MOV P1, #0C0h  ; comando para mover el cursor a la segunda línea
    ACALL cmd
    MOV DPTR, #ApellidoStr
aca2:
    CLR A
    MOVC A, @A+DPTR
    CJNE A, #0, next_character2
    SJMP end_surname
next_character2:
    MOV P1, A
    ACALL display
    INC DPTR
    SJMP aca2
end_surname:
    RET

cmd:
    ACALL delay
    CLR RS
    ACALL delay
    SETB E
    CLR E
    SETB RS
    RET

display:
    ACALL delay
    SETB RS
    ACALL delay
    SETB E
    CLR E
    CLR RS
    RET

delay:
    MOV R7, #255
again: DJNZ R7, again
    RET

NombreStr: DB 'Uriel', 0
ApellidoStr: DB 'Mendoza', 0

END
