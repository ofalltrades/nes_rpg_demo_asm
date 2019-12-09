	processor 6502

	include "nes_consts.asm"
	include "nes_macros.asm"


;------------ variables
	seg.u _ZeroPage_			; define a segment for zero page variables
	org $0			; start segment at $0

_scroll_x	byte			; used during NMI
_scroll_y	byte			; used during NMI


;------------ nes cartridge header
	seg _Header_			; define segment for NES header
	org HEADER_START			; start header at $7FF0, 16 bytes before code seg

	NESHeader 0, 2, 1, 0 		; mapper 0, 2 PRGs, 1 CHR, hoz scrolling


;------------ start of code
	seg _Code_			; define segment for start of code
	org PRG_ROM_START			; start segment at $8000

start:	subroutine			; the address the CPU begins execution on cosole reset
	NESInit			; set up stack pointer, turn off PPU
        	jsr wait_vsync			; wait for VSYNC (start of waiting on PPU to warm up)
       	jsr clear_ram			; clear RAM
        	jsr wait_vsync			; wait for VSYNC (next video frame) and end of PPU warm up
	jsr init_sprites
	jsr set_palette
	jsr fill_vram
	lda #0
	sta PPU_ADDR_REG			; clear high byte; 0 -> MEM[$2006][<high byte>]
        	sta PPU_ADDR_REG    		; clear low byte; 0 -> MEM[$2006][<low byte>]
	sta PPU_SCROLL_REG			; clear high byte; 0 -> MEM[$2005][<high byte>]
	sta PPU_SCROLL_REG			; clear low byte; 0 -> MEM[$2005][<low byte>]
	lda #MASK_BG | MASK_SPR		;
	sta PPU_MASK_REG			; enable rendering
	lda #CTRL_NMI_BIT
	sta PPU_CTRL_REG			; enable NMI
._				; infinite loop
	jmp ._


;------------ local subroutines
set_palette:	subroutine			; load colors from palette_data lookup table into PPU
	PPUSetAddr #PAL_START		; set PPU addr to $3f00
	ldy #0			; clear Y
._
	lda palette_data,y			; lookup byte in table
	sta PPU_DATA_REG			; store byte in PPU data; PPU increments PPU address each write
	iny
	cpy #PAL_SIZE			; (Y == 32)?
	bne ._			; branch if haven't looped for each byte in table (32 times)
	rts


fill_vram: 	subroutine
	PPUSetAddr #NAMETABLE_START
	ldy #$10
	ldx #0
._
	stx PPU_DATA_REG
	inx
	bne ._
	dey
	bne ._
	rts


update_sprites:
	rts


;------------ common subroutines
	include "lib_ppu.asm"
	include "lib_io.asm"


;------------ interrupt handlers
nmi_handler:				; runs every video frame before vertical blank
	PushAXY			; save registers
	jsr read_gamepad_1			; fill A with gamepad polling result
	pha			; <gamepad state> ->> Stack[]
	and #%0000011			; mask first 2 bits
	tay 			; A -> Y
	lda scroll_dir_table,y		; lookup table
	clc
	adc _scroll_x			; compute (A + _scroll_x) with Carry
	sta _scroll_x			; A -> MEM[@_scroll_x]
	sta PPU_SCROLL_REG			; set hoz scroll pos; A -> MEM[$2005]
	pla			; Stack[@<gamepad state>] -> A
	lsr			; shift right 2 bits to get up/down swtiches
	lsr
	and #%0000011			; mask first 2 bits
	tay			; A -> Y
	lda scroll_dir_table,y
	clc
	adc _scroll_y			; compute (A + _scroll_y) with Carry
	sta _scroll_y			; A -> MEM[@_scroll_y]
	sta PPU_SCROLL_REG			; set vert scroll pos; A -> MEM[$2005]
	jsr update_sprites
	PullAXY			; restore registers
	rti


;------------ data
scroll_dir_table:				; scroll direction lookup table
	hex 00 01 ff 00			; 0, 1, -1, 0


	align $100			; align current PC to a $100 boundry; fill with 0s

palette_data:				; set raw hex data for palette -- 32-byte lookup table ($3f00-$3f1f)
	hex 1f			; screen color
	hex 01 11 21 00			; background 0
	hex 02 12 22 00			; background 1
	hex 02 11 21 00			; background 2
	hex 01 12 22 00			; background 3
	hex 19 29 39 00			; sprite 0
	hex 1a 2a 3a 00			; sprite 1
	hex 1b 2b 3b 00			; sprite 2
	hex 1c 2c 3c			; sprite 3


page_data:
	hex 00
	hex 42 42 42 42	; 'B'
	hex 41 41 41 41	; 'A'


;------------ cpu vectors
	NESSetVectors


;------------ tile sets
	org CHR_ROM_START			; start CHR data after 2 PRG banks specified in header ($8000-$FFFF)
	incbin "jroatch.chr"
	incbin "jroatch.chr"
