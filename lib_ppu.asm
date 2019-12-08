wait_vsync:	subroutine			; WARNING: unreliable; only use for PPU warm up; use NMI handler during game
        	bit PPU_STATUS_REG			; check high bit of PPU_STATUS_REG (bit 7 -> N flag)
	bpl wait_vsync			; loop while N flag is clear
	rts			; return if high bit if PPU_STATUS_REG is set


clear_ram:	subroutine 			; clear CPU-accessible RAM
	lda #0			; set A and X to zero
	tax			; A -> X
.clear				;
	sta $0, x			; 0 -> [$0 + X]
	cpx #$fe 			; last 2 bytes of stack?
	bcs .without_stack			; don't clear stack
	sta $100, x			; 0 -> [$100 + X]
.without_stack				;
	sta $200, x			; 0 -> [$200 + X]
	sta $300, x			; 0 -> [$300 + X]
	sta $400, x			; 0 -> [$400 + X]
	sta $500, x			; 0 -> [$500 + X]
	sta $600, x			; 0 -> [$600 + X]
	sta $700, x			; 0 -> [$700 + X]
	inx 			;
	bne .clear 			; loop until X = 0
	rts			;
