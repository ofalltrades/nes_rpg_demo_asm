	processor 6502

	include "nes_consts.asm"
	include "nes_macros.asm"
	include "ppu_macros.asm"
	include "mmc1_macros.asm"


;------------ variables
	seg.u _ZeroPage_			; define a segment for zero page variables
	org $0			; start segment at $0

_prg_bank	byte			; current PRG ROM bank
_prg_bank_mode	byte
_retrace_cycle	byte			; used to wait for VBlank
_scroll_x	byte			; used during NMI
_scroll_y	byte			; used during NMI
_curr_mirr	byte			; current mirroring scheme


;------------ nes cartridge header
	seg _Header_			; define segment for NES header
	org HEADER_ADDR			; start header at $7FF0, 16 bytes before PRG ROM data

	NESHeader 1, 16, 16, 3 		; mapper 1 (MMC1), 16 16K PRG pages (256K), 16 * 8K CHR ROM, hoz mirroring


;------------ start of code
	seg _Code_			; define segment for start of code
	org CODE_ADDR			; start segment at $c000

start:	subroutine			; the address the CPU begins execution on cosole reset
	NESInit			; set up stack pointer, turn off PPU
	MMC1Init			; set mapper to known state
        	lda #3
	sta _curr_mirr			; initialize _curr_mirr to 3 — hoz
	jsr wait_stat_vflag			; 1st PPU warm-up wait; ~27,384 cycles long
	txa			; prepare for clear mem; 0 -> A; X is still 0 from inx in NESInit
.clear_ram
	sta $000,x			; 0 -> MEM[$0 + X]
	sta $100,x			; 0 -> MEM[$100 + X]; stack is $100-$1FF
	sta $200,x			; 0 -> MEM[$200 + X]
	sta $300,x			; 0 -> MEM[$300 + X]
	sta $400,x			; 0 -> MEM[$400 + X]
	sta $500,x			; 0 -> MEM[$500 + X]
	sta $600,x			; 0 -> MEM[$600 + X]
	sta $700,x			; 0 -> MEM[$700 + X]
	inx
	bne .clear_ram 			; loop until X = 0
	SetPrgBnk #PRG_BANK_1
	jsr wait_stat_vflag			; 2nd for PPU to warm up; ~57,165 cycles long
	jsr set_palette
	lda #%00000001                                              ; prepare to init sprites
	ldx #0
.fill_spr_buf
	sta SPRITE_BUF_ADDR,y		; store %00000001 at MEM[$200 + Y]
	inx
	bne .fill_spr_buf			; loop until X wraps
	jsr fill_vram
	lda #0
	sta PPU_ADDR_REG			; clear high byte; 0 -> MEM[$2006][<high byte>]
        	sta PPU_ADDR_REG    		; clear low byte; 0 -> MEM[$2006][<low byte>]
	sta PPU_SCROLL_REG			; clear high byte; 0 -> MEM[$2005][<high byte>]
	sta PPU_SCROLL_REG			; clear low byte; 0 -> MEM[$2005][<low byte>]
	lda #[BG_MASK | SPR_MASK]
	sta PPU_MASK_REG			; enable rendering
	lda #PPU_CTRL_NMI_BIT
	sta PPU_CTRL_REG			; enable NMI
._				; infinite loop
	jmp ._


;------------ local subroutines
set_palette:	subroutine			; load colors from palette_data lookup table into PPU
	PPUSetAddr #PAL_ADDR		; set PPU addr to $3f00
	ldy #0			; clear Y
._
	lda palette_data,y			; lookup byte in table
	sta PPU_DATA_REG			; store byte in PPU data; PPU increments PPU address each write
	iny
	cpy #PAL_SIZE			; (Y == 32)?
	bne ._			; branch if haven't looped for each byte in table (32 times)
	rts


fill_vram: 	subroutine			; fill nametable mem with data (letters representing nametable)
	PPUSetAddr #NAMETABLE_ADDR		; set PPU addr to $2000
	ldy #$10			; total pages to set (<$10 pages> == <$1000 bytes>)
._
	lda page_data,y			; page_data[Y] -> A
	sta PPU_DATA_REG			; A -> MEM[@<PPU data port>]
	inx			; X is init 0 due to init-ing sprites
	bne ._
	dey
	bne ._
	rts


update_sprites:
	rts


;------------ common subroutines
	include "lib_ppu.asm"
	include "lib_io.asm"
	include "lib_nes.asm"
	include "lib_mmc1.asm"


;------------ interrupt handlers
nmi_handler:				; runs every video frame before vertical blank
	inc _retrace_cycle			; <NMI-check count> + 1
	PushAXY			; save registers
	jsr read_gamepad_1			; fill A with gamepad polling result
	pha			; <gamepad state> ->> Stack[]
	jsr mmc1_update
	and #%00000011			; mask first 2 bits
	tay 			; A -> Y
	lda scroll_dir_table,y		; lookup table
	clc
	adc _scroll_x			; compute (A + _scroll_x) with Carry
	sta _scroll_x			; A -> MEM[_scroll_x]
	sta PPU_SCROLL_REG			; set hoz scroll pos; A -> MEM[$2005]
	pla			; Stack[@<gamepad state>] -> A
	lsr			; shift right 2 bits to get up/down swtiches
	lsr
	and #%00000011			; mask first 2 bits
	tay			; A -> Y
	lda scroll_dir_table,y
	clc
	adc _scroll_y			; compute (A + _scroll_y) with Carry
	;;; TODO: don't set this unless _scroll_x == 0, to prevent diagnal scrolling
	sta _scroll_y			; A -> MEM[_scroll_y]
	sta PPU_SCROLL_REG			; set vert scroll pos; A -> MEM[$2005]
	jsr update_sprites
	PullAXY			; restore registers
	rti


;------------ data
scroll_dir_table:				; scroll direction lookup table
	hex 00 01 ff 00			; 0, 1, -1, 0


	align $100			; align current PC to a $100 boundry; fill with 0s
palette_data:				; set raw hex data for palette -- 32-byte lookup table ($3f00-$3f1f)
	hex 1c			; screen color
	hex 01 11 21 00			; bg 0
	hex 02 12 22 00			; bg 1
	hex 02 11 21 00			; bg 2
	hex 01 12 22 00			; bg 3
	hex 19 29 39 00			; sprite 0
	hex 1a 2a 3a 00			; sprite 1
	hex 1b 2b 3b 00			; sprite 2
	hex 1c 2c 3c			; sprite 3


page_data:				; set raw hex data for pages
	hex 00			; idx 0 not used
	hex 44 44 44 44			; 'D'
	hex 43 43 43 43			; 'C'
	hex 42 42 42 42			; 'B'
	hex 41 41 41 41			; 'A'


;------------ code reset shim
	org CODE_RST_SHIM_ADDR

	InsertResetShim


;------------ cpu vectors
	seg _Vectors_			; define segment for NES vectors
	org VECTORS_ADDR			; start at address $fffa

	NESSetVectors


;------------ banks
	include "prg_bank_0.asm"
	include "prg_bank_1.asm"


;------------ tile sets
	org CHR_ROM_ADDR			; start CHR data after 2 PRG banks specified in header ($8000-$FFFF)

	incbin "jroatch.chr"
	incbin "jroatch.chr"
