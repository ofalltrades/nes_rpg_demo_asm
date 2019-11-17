
	mac NesHeader
	seg header
	org $7ff0
.nes_mapper	SET {1}    			; mapper number
.nes_prg_banks	SET {2}    			; num of 16K PRG banks, change to 2 for NROM256
.nes_char_banks	SET {3}    			; num of 8K CHR banks (0 = RAM)
.nes_mirroring	SET {4}    			; 0 horizontal, 1 vertical, 8 four screen
	byte $4e,$45,$53,$1a    		; header
	byte .nes_prg_banks
	byte .nes_char_banks
	byte .new_mirroring | (.new_mapper <<4)
	byte .new_mapper & $f0
	byte 0, 0, 0, 0, 0, 0, 0, 0    		; reserved, set to zero
	seg Code
	org $8000
	endm

        	mac NesInit
        	sei    			; disable IRQs
        	cld    			; decimal mode not supported
        	ldx #$ff
        	txs    			; set up stack pointer
        	inx    			; inc X to 0
        	stx PPU_MASK    			; disable rendering
        	stx DMC_FREQ    			; disable DMC interrupts
        	stx PPU_CTRL    			; disable NMI interrupts
	bit PPU_STATUS    			; clear VBL flag
        	bit APU_CHAN_CTRL   		; ack DMC IRQ bit 7
	lda #$40
	sta APU_FRAME    			; disable APU Frame IRQ
	lda #$0F
	sta APU_CHAN_CTRL			; disable DMC, enable/init other channels.
        	endm
