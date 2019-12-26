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

