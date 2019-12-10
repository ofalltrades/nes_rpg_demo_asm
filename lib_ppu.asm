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


clear_ram:	subroutine			; clear CPU-accessible RAM
	txa			; 0 -> A; X is still 0 from inx setting it in NESInit
.clear
	sta $000,x			; 0 -> [$0 + X]
	cpx #$fe 			; set Carry flag if (X >= 254)
	bcs .without_stack			; don't clear stack
	sta $100,x			; 0 -> [$100 + X]
.without_stack
	sta $200,x			; 0 -> [$200 + X]
	sta $300,x			; 0 -> [$300 + X]
	sta $400,x			; 0 -> [$400 + X]
	sta $500,x			; 0 -> [$500 + X]
	sta $600,x			; 0 -> [$600 + X]
	sta $700,x			; 0 -> [$700 + X]
	inx
	bne .clear 			; loop until X = 0
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
