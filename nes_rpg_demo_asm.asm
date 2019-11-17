; macros:	FooBarBaz
; subroutines:	foo_bar_baz
; defs/consts:	FOO_BAR_BAZ
; variables:	_foo_bar_baz
; segs:	foo_bar_baz

	include "lib_ppu.asm"
	include "nes_defs.asm"
        	include "nes_macros.asm"

;;;;; variables

	seg.u zero_page
	org $0

;;;;; nes cartridge header

	NesHeader 0, 2, 1, NES_MIRR_HORIZ 		; mapper 0, 2 PRGs, 1 CHR

;;;;; start of code

start:	subroutine
	NesInit			; set up stack pointer, turn off PPU
        	jsr WaitVSync			; wait for VSYNC
       	jsr ClearRAM			; clear RAM
        	jsr WaitVSync			; wait for VSYNC (and PPU warmup)

	include "nes_macros.asm"

	lda #$3f			; $3F -> A register
        	ldy #$00			; $00 -> Y register
        	sta PPU_ADDR			; write high byte first
        	sty PPU_ADDR    			; $3F00 -> PPU address
        	lda #$1c			; $1C = light blue color
        	sta PPU_DATA    			; $1C -> PPU data
        	lda #CTRL_NMI
        	sta PPU_CTRL			; enable NMI
        	lda #MASK_COLOR
        	sta PPU_MASK			; enable rendering
._
	jmp ._			; endless loop

;;;;; common subroutines

	include "lib_ppu.asm"

;;;;; interrupt handlers

nmi_handler: 	subroutine
	SAVE_REGS
	RESTORE_REGS
	rti

;;;;; cpu vectors

	NES_VECTORS
