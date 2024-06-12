PORTB = $6000
PORTA = $6001
DDRB = $6002
DDRA = $6003

E  = %10000000
RW = %01000000
RS = %00100000

  .org $1000

reset:

  jsr LCD__initialize

  lda #%10000000
  jsr LCD__set_cursor:
  
  ldx #$00
out:
  lda message,x
  beq secl
  jsr print
  inx
  jmp out

secl:
  jsr LCD__set_cursor_second_line:

  ldx #$00
out1:
  lda message1,x
  beq halt
  jsr print
  inx
  jmp out1

halt:
  jmp $FF00

message: .asciiz "Hello World!"
message1: .asciiz "BV2CI Eugene"

LCD__initialize:
    lda #%11111111 ; set all pins on port B to output
    sta DDRB
    lda #%11111111 ; set all pins on port A to output
    sta DDRA
    lda #%00111000       ; set 8-bit mode, 2-line display, 5x8 font
    jsr LCD__send_instruction
    lda #%00001110       ; display on, cursor on, blink off
    jsr LCD__send_instruction
    lda #%00000110       ; increment and shift cursor, don't shift display
    jmp LCD__send_instruction

LCD__set_cursor:
    jmp LCD__send_instruction

LCD__set_cursor_second_line:
    pha                   ; preserve A
    lda #%11000000        ; set cursor to line 2 hardly
    jsr LCD__send_instruction
    pla                   ; restore A
    rts

LCD__check_busy_flag:
    lda #0                ; clear port A
    sta PORTA             ; clear RS/RW/E bits
    lda #RW               ; prepare read mode
    sta PORTA
    bit PORTB             ; read data from LCD
    bpl .ready            ; bit 7 not set -> ready
    lda #1                ; bit 7 set, LCD is still busy, need waiting
    rts
.ready:
    lda #0
.return:
    rts

LCD__send_instruction:
    pha
.loop
    jsr LCD__check_busy_flag
    bne .loop
    pla
    sta PORTB                     ; write accumulator content into PORTB
    lda #E
    sta PORTA                     ; set E bit to send instruction
    lda #0
    sta PORTA                     ; clear RS/RW/E bits
    rts

LCD__send_data:
    sta PORTB
    lda #(RS | E)
    sta PORTA
    lda #0
    sta PORTA
    rts

print:
	sta PORTB
	lda #RS
	sta PORTA
	lda #(RS | E)
	sta PORTA
	lda #RS
	sta PORTA
	rts

dly0: 	sbc #7
delaya: 	
	cmp #7
 	bcs dly0
 	lsr
 	bcs dly1
dly1: 	beq dly2
  lsr
  beq dly3
  bcc dly3
dly2:  	bne dly3
dly3: 	rts
