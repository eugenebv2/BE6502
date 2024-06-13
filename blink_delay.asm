mscnt    .equ 0c6h	; 1Mhz for delay routine

    .org $1000

    lda #$ff		; set PORTB output
    sta $6002
    lda #$ff		; set PORTA output
    sta $6003

init:
    lda #$ff
    sta ledcount 
loop:
    lda ledcount
    sta $6000
    jsr delayone
    dec ledcount
    bne loop
    jmp init

count .byte 0
ledcount .word 0

delayone:
    lda #1
    sta count
dela:
    ldy #250
    jsr delay
    dec count
    bne dela
    rts

delay:        ; Delay Milliseconds (DELAY)  From "6502 Assembly language Subroutines"
    cpy #0
    beq exit
    nop
    cpy #1
    bne delaya
    jmp last1
delaya:
    dey
delay0:
    ldx #mscnt
delay1:
    dex
    bne delay1
    nop
    nop
    dey
    bne delay0
last1:
    ldx #mscnt-3
delay2:
    dex
    bne delay2
exit:
    rts
