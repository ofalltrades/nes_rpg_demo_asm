wait_vblank:	subroutine			; reliable VBlank wait for game code taking ~24k cycles or less
        	lda _nmi_check_count		; MEM[@_nmi_check_count] -> A
._
	cmp _nmi_check_count		; has value changed?
	beq ._			; loop until _nmi_check_count has been mutated
	rts


wait_stat_vflag:				; unreliable VBlank wait
        	bit PPU_STATUS_REG			; check if bit 7 (VBlank flag) high
	bpl wait_stat_vflag			; loop while VBlank flag is 0
	rts


init_sprites:	subroutine
	lda #%00000001
	ldx #0
._
	sta SPRITE_BUF_START,y		; store %00000001 at [$200 + Y]
	jsr foo
	inx
	bne ._			; loop until X wraps
	rts

foo: 	subroutine
	lsr
	rts
