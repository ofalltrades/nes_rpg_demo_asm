
	MAC NESHeader			; desc: build NES header; args: mapper, num of PRGs, num of CHRs
.nes_mapper	set {1}    			; mapper number
.nes_prg_banks	set {2}    			; num of 16K PRG banks, change to 2 for NROM256
.nes_chr_banks	set {3}    			; num of 8K CHR banks (0 = RAM)
.nes_mirroring	set {4}    			; 0 = horiz, 1 = vert, 8 = four screens
	byte $4e, $45, $53, $1a    		; header: 'N', 'E', 'S', ' '
	byte .nes_prg_banks			;
	byte .nes_chr_banks			;
	byte .nes_mirroring | (.nes_mapper << 4)	;
	byte .nes_mapper & $f0		;
	byte 0, 0, 0, 0, 0, 0, 0, 0    		; reserved, set to zero
	ENDM			;


        	MAC NESInit			; desc: init NES; args: none
        	sei    			; set I flag, disable IRQs (interrupt requests)
        	cld    			; clear D flag (decimal)
        	ldx #$ff			; set up stack pointer (S register):
        	txs    			;   $ff -> X; X -> stack pointer
        	inx    			; inc X to 0 ($ff + 1 = 0)
        	stx PPU_MASK_REG    		; disable PPU rendering
        	stx DMC_FREQ_REG   			; disable DMC interrupts
        	stx PPU_CTRL_REG    		; disable NMI interrupts
	bit PPU_STATUS_REG    		; reset VBL, sprite zero, and internal high/low byte-flipping flags
        	bit APU_CHAN_CTRL_REG   		; ack DMC IRQ bit 7
	lda #$40			;
	sta APU_FRAME_REG    		; disable APU Frame IRQ
	lda #$0f		 	;
	sta APU_CHAN_CTRL_REG		; disable DMC, enable/init other channels.
        	ENDM

	MAC NESVectors			; desc: set nes vectors; args: none
	seg _Vectors_			;
	org $fffa			; start at address $fffa
	.word nmi_handler			;
	.word start			;
	.word nmi_handler			;
	ENDM			;			;


	MAC SaveAXY			; desc: save A/X/Y registers; args: none
	pha			; A -> Stack
	txa			; X -> A
	pha			; A ->> Stack (X pushed to stack)
	tya			; Y -> A
	pha			; A ->> Stack (Y pushed to stack)
	ENDM			;


	MAC RestoreAXY			; desc: restore Y/X/A registers; args: none
	pla			; pull from stack (<Saved Y> -> A)
	tay			; A -> Y (Transfer Accumulator to Index Y)
	pla			; pull from stack (<Saved X> -> A)
	tax			; A -> X (Transfer Accumulator to Index X)
	pla			; pull from stack (<Saved A> -> A)
	ENDM			;
