	processor 6502

	include "nes_defs.asm"
	include "lib_ppu.asm"
	include "nes_macros.asm"


;------------ variables
	seg.u _ZeroPage_			; define a segment for zero page variables
	org $0			; start segment at $0

_scroll_x	byte			; used during NMI
_scroll_y	byte			; used during NMI


;------------ nes cartridge header
	seg _Header_			; define segment for NES header
	org $7ff0			; start header at $7FF0, 16 bytes before code seg

	NESHeader 0, 2, 1, 0 		; mapper 0, 2 PRGs, 1 CHR, horiz scrolling


;------------ start of code
	seg _Code_			; define segment for start of code
	org $8000			; start segment at $8000

start:				; the address the CPU begins execution on cosole reset
	NESInit			; set up stack pointer, turn off PPU
        	jsr wait_vsync			; wait for VSYNC (start of waiting on PPU to warm up)
       	jsr clear_ram			; clear RAM
        	jsr wait_vsync			; wait for VSYNC (next video frame) and end of PPU warm up
	lda #SCRN_COL_HIGH_BYTE		; $3F -> A
        	ldy #SCRN_COL_LOW_BYTE		; $00 -> Y
        	sta PPU_ADDR_REG			; write high byte first
        	sty PPU_ADDR_REG    		; $3F00 -> PPU address
        	lda #LIGHT_BLUE			; $1C = light blue color
        	sta PPU_DATA_REG    		; $1C -> PPU data reg
	lda #MASK_BG_BIT			; A = $08; enable rendering of the background
        	sta PPU_MASK_REG			; enable rendering
        	lda #CTRL_NMI_BIT			; A = $80			;
        	sta PPU_CTRL_REG			; enable NMI
._				; infinite loop
	jmp ._			;

;------------ common subroutines
	include "lib_ppu.asm"


;------------ interrupt handlers
nmi_handler:
	SaveAXY
	RestoreAXY
	rti


;------------ cpu vectors
	NESVectors
