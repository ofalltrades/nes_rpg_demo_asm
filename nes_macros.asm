
	MAC NESHeader			; desc: build NES header; args: mapper, PRG banks, CHR banks, scroll dir
.nes_mapper	set {1}    			; mapper number
.nes_prg_banks	set {2}    			; num of 16K PRG banks, change to 2 for NROM256
.nes_chr_banks	set {3}    			; num of 8K CHR banks (0 = RAM)
.nes_mirroring	set {4}    			; 0 = hoz, 1 = vert, 8 = four screens
	byte "NES", $1a    			; header: $4e, $45, $53, ' '
	byte .nes_prg_banks
	byte .nes_chr_banks
	byte .nes_mirroring | (.nes_mapper << 4)
	byte .nes_mapper & $f0
	byte 0, 0, 0, 0, 0, 0, 0, 0    		; reserved, set to zero
	ENDM


        	MAC NESInit			; desc: init NES; args: none
        	sei    			; set I flag, disable IRQs (interrupt requests)
        	cld    			; clear D flag (decimal)
        	ldx #$ff			; set up stack pointer (S register): REVISIT/HOW IS STACK POINTER SET TO $FF HERE
        	txs    			;     $ff (stack pointer) -> X
        	inx    			; inc X to 0 ($ff + 1 = 0) -- clear_ram relies on X == 0
        	stx PPU_MASK_REG    		; disable PPU rendering
        	stx DMC_FREQ_REG   			; disable DMC interrupts
        	stx PPU_CTRL_REG    		; disable NMI interrupts
	bit PPU_STATUS_REG    		; reset VBlank, sprite zero, and internal high/low byte-flipping flags
        	bit APU_CHAN_CTRL_REG   		; ack DMC IRQ bit 7
	lda #$40
	sta APU_FRAME_REG    		; disable APU Frame IRQ
	lda #$0f
	sta APU_CHAN_CTRL_REG		; disable DMC, enable/init other channels.
        	ENDM


	MAC InitMMC1			; desc: resets the mapper; args: none
	lda #%10000000			; bit 7 high
	sta $8000			; shift reg rather than ROM; reset mapper (bit 7 set)
	lda #%00001111			; mirroring mode 3, PRG ROM bank mode 3, CHR ROM bank mode 0
	sta $8000			; feed bit 0 to MMC1 shift register -- 1st bit of orig val
	lsr
	sta $8000			; feed 2nd bit of orig val to mapper
	lsr
	sta $8000			; feed 3rd bit of orig val to mapper
	lsr
	sta $8000			; feed 4th bit of orig val to mapper
	lsr
	sta $8000			; feed orig 5th bit; set mirroring; addr must be precise
	stx $a000 			; clear CHR reg; X = 0 via clear_ram
	stx $a000
	stx $a000
	stx $a000
	stx $a000			; 5th write finalized CHR reg clear
	ENDM


	MAC SetPrgBnk			; desc: switch PRG ROM banks; args: prg bank (0-15)
	lda {1}			; <bank num> -> A
                    sta $e000			; feed bit 0 to MMC1 shift register -- 1st bit of orig val
                    lsr			; discard bit 0 so next val can be sent
                    sta $e000			; feed 2nd bit of orig val to mapper
                    lsr			; discard bit 0 so next val can be sent
                    sta $e000			; feed 3rd bit of orig val to mapper
                    lsr			; discard bit 0 so next val can be sent
                    sta $e000			; feed 4th bit of orig val to mapper
                    lsr			; discard bit 0 so next val can be sent
                    sta $e000			; feed orig 5th bit; causes bank switch; addr must be precise
                    ENDM


	MAC NESSetVectors			; desc: set NES vectors; args: none
	.word nmi_handler			; $fffa -- at VBlank go to nmi_handler address
	.word start			; $fffc -- at power on or reset go to $8000
	.word nmi_handler			; $fffe -- when requested by apu or mapper, go to nmi_handler address
	ENDM


	MAC PPUSetAddr			; desc: set 16-bit PPU addr; args: upper byte, lower byte
	lda #>{1}			; load upper byte into A
	ldy #<{1}			; load lower byte into Y
	sta PPU_ADDR_REG			; A -> $2006
	sty PPU_ADDR_REG			; Y -> $2006
	ENDM


	MAC PPUSetVal			; desc: store 8-bit val in PPU data reg; args: value
	lda #{1}			; load arg into A
	sta PPU_DATA_REG			; A -> $2007
	ENDM


	MAC PushAXY			; desc: save A/X/Y registers; args: none
	pha			; A ->> Stack[]
	tya			; Y -> A
	pha			; A ->> Stack[] -- (X pushed onto stack)
	txa			; X -> A
	pha			; A ->> Stack[] -- (Y pushed onto stack)
	ENDM


	MAC PullAXY			; desc: restore Y/X/A registers; args: none
	pla			; pull from stack (<Saved Y> -> A)
	tax			; A -> X (Transfer Accumulator to Index X)
	pla			; pull from stack (<Saved X> -> A)
	tay			; A -> Y (Transfer Accumulator to Index Y)
	pla			; pull from stack (<Saved A> -> A)
	ENDM


	; MAC Sleep			; desc: ; args: num of cycles to sleep
	; ldy {1}
	; if A & 1
	; bit $00
	; dey			; cycles - 3
	; dey
	; dey
