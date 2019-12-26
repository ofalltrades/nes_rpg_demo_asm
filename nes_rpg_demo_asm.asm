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

                    NESHeader 1, 16, 1, 3 		; mapper 1 (MMC1), 16 16K PRG pages (256K), 16 * 8K CHR ROM, hoz mirroring


;------------ banks
                    include "prg_bank_0.asm"
                    include "prg_bank_1.asm"
                    include "prg_bank_2.asm"
                    include "prg_bank_3.asm"
                    include "prg_bank_4.asm"
                    include "prg_bank_5.asm"
                    include "prg_bank_6.asm"
                    include "prg_bank_7.asm"
                    include "prg_bank_8.asm"
                    include "prg_bank_9.asm"
                    include "prg_bank_10.asm"
                    include "prg_bank_11.asm"
                    include "prg_bank_12.asm"
                    include "prg_bank_13.asm"
                    include "prg_bank_14.asm"
                    include "prg_bank_15.asm"


;------------ tile sets
                    org CHR_ROM_ADDR			; start CHR data after 2 PRG banks specified in header ($8000-$FFFF)

                    incbin "jroatch.chr"
                    incbin "jroatch.chr"
