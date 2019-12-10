wait_vblank:	subroutine			; reliable VBlank wait for game code taking ~24k cycles or less
        	lda _retrace_cycle			; MEM[@_retrace_cycle] -> A
._
	cmp _retrace_cycle			; has value changed?
	beq ._			; loop until _retrace_cycle has been mutated
	rts


wait_stat_vflag:				; unreliable VBlank wait
        	bit PPU_STATUS_REG			; check if bit 7 (VBlank flag) high
	bpl wait_stat_vflag			; loop while VBlank flag is 0
	rts


init_sprites:	subroutine
	lda #%00000001
	ldx #0
._
	sta SPRITE_BUF_ADDR,y		; store %00000001 at [$200 + Y]
	jsr foo
	inx
	bne ._			; loop until X wraps
	rts

foo: 	subroutine
	lsr
	rts
