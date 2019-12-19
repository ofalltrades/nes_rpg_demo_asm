                    MAC MMC1LoadStateReg                                             ; desc: load A into MMC1 shift register; args: none
                    sta $8000			; feed bit 0 to MMC1 shift register -- 1st bit of orig val
	lsr
	sta $8000			; feed 2nd bit of orig val to mapper
	lsr
	sta $8000			; feed 3rd bit of orig val to mapper
	lsr
	sta $8000			; feed 4th bit of orig val to mapper
	lsr
	sta $8000			; feed orig 5th bit; set mirroring; addr must be precise
                    ENDM


                    MAC MMC1Init			; desc: FILL ME IN; args: none
	lda #%10000000			; bit 7 high
	sta $8000			; shift reg rather than ROM; reset mapper (bit 7 set)
	lda #%00001111			; mirroring mode 3, PRG ROM bank mode 3, CHR ROM bank mode 0
	MMC1LoadStateReg
	stx $a000 			; clear CHR reg; X = 0 via clear_ram and reset
	stx $a000
	stx $a000
	stx $a000
	stx $a000			; 5th write finalized CHR reg clear
	ENDM


                    MAC MMC1ToggleMirroring                                     ; desc: toggle between vert and hoz mirroring; args: none
                    lda #_curr_mirr
                    eor #%01                                                    ; toggle lowest bit (between %00000011 and %00000010)
                    sta _curr_mirr
                    ldy #%10000000			; bit 7 high
	sty $8000			; shift reg rather than ROM; reset mapper (bit 7 set)
                    and #%00001111                                              ; mirroring mode toggled, PRG ROM bank mode 3, CHR ROM bank mode 0
                    MMC1LoadStateReg
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


                    MAC InsertResetShim
                    jmp start
	ENDM
