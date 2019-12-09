
	MAC NESHeader			; desc: build NES header; args: mapper, num of PRGs, num of CHRs
.nes_mapper	set {1}    			; mapper number
.nes_prg_banks	set {2}    			; num of 16K PRG banks, change to 2 for NROM256
.nes_chr_banks	set {3}    			; num of 8K CHR banks (0 = RAM)
.nes_mirroring	set {4}    			; 0 = hoz, 1 = vert, 8 = four screens
	byte $4e, $45, $53, $1a    		; header: 'N', 'E', 'S', ' '
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
        	inx    			; inc X to 0 ($ff + 1 = 0)
        	stx PPU_MASK_REG    		; disable PPU rendering
        	stx DMC_FREQ_REG   			; disable DMC interrupts
        	stx PPU_CTRL_REG    		; disable NMI interrupts
	bit PPU_STATUS_REG    		; reset VBL, sprite zero, and internal high/low byte-flipping flags
        	bit APU_CHAN_CTRL_REG   		; ack DMC IRQ bit 7
	lda #$40
	sta APU_FRAME_REG    		; disable APU Frame IRQ
	lda #$0f
	sta APU_CHAN_CTRL_REG		; disable DMC, enable/init other channels.
        	ENDM


	MAC NESSetVectors			; desc: set NES vectors; args: none
	seg _Vectors_			; define segment for NES vectors
	org VECTOR_START			; start at address $fffa
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
