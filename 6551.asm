; 6551 Chip registers
ACIA        = $5000 ;$4000 ;$8800
ACIA_CTRL   = ACIA+3
ACIA_CMD    = ACIA+2
ACIA_SR     = ACIA+1
ACIA_DAT    = ACIA

MSGL = $2C
MSGH = $2D

CR = $0A ; carriage return
LF = $0D ; line feed

      .org $1000

; Set no parity, no echo, RTS low, no RX interrupts, DTR low  
      LDA #$0B
      STA ACIA_CMD
; Set 1 stop bit, 8 bit data, 19200bps
      LDA #$1F
      STA ACIA_CTRL

; Display OK\n
      LDA #LF
      JSR ECHO
      LDA #'O'
      JSR ECHO
      LDA #'K'
      JSR ECHO
      LDA #LF
      JSR ECHO

      LDA #<MSG1
      STA MSGL
      LDA #>MSG1
      STA MSGH
      JSR SHWMSG
      LDA #LF
      JSR ECHO

; Now get a character and echo it back
; Quit if it is 'Q'
LOOP: JSR GETCHAR
      CMP #'Q'
      BEQ DONE
      JSR ECHO
      JMP LOOP

DONE: JMP $FF00

MSG1 .byte "6551 commumication Ready! Type 'Q' back to Monitor.",0

; Send character in A out serial port
ECHOA:  PHA
        LDA #$10
TXFULL: BIT ACIA_SR ; wait for TDRE bit = 1
        BEQ TXFULL
        PLA
        STA ACIA_DAT
        RTS

ECHO:   PHA             ;*Save A
        AND #$7F        ;*Change to "standard ASCII"
        STA ACIA_DAT    ;*Send it.
.WAIT   LDA ACIA_SR     ;*Load status register for ACIA
        AND #$10        ;*Mask bit 4.
        BEQ    .WAIT    ;*ACIA not done yet, wait.
        PLA             ;*Restore A
        RTS             ;*Done, over and out...

SHWMSG  LDY #$0
.PRINT  LDA (MSGL),Y
        BEQ .DONE
        JSR ECHO
        INY 
        BNE .PRINT
.DONE   RTS 

; Read character from serial port and return in A
GETCHAR:    LDA ACIA_SR     ; See if we got an incoming char
            AND #$08        ; Test bit 3
            BEQ GETCHAR     ; Wait for character
            LDA ACIA_DAT    ; Load char
            RTS
