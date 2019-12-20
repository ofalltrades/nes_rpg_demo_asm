;------------ PPU registers
PPU_CTRL_REG	equ  $2000
PPU_MASK_REG	equ  $2001
PPU_STATUS_REG	equ  $2002
OAM_ADDR_REG	equ  $2003
OAM_DATA_REG	equ  $2004
PPU_SCROLL_REG	equ  $2005
PPU_ADDR_REG	equ  $2006
PPU_DATA_REG	equ  $2007


;------------ PPU ROM
PAL_ADDR	equ  $3f00


;------------ APU, I/O registers
DMC_FREQ_REG	equ  $4010
PPU_OAM_DMA_REG	equ  $4014
APU_CHAN_CTRL_REG	equ  $4015
APU_FRAME_REG	equ  $4017


;------------ working RAM
HEADER_ADDR         equ  $7ff0


;------------ PRG ROM
PRG_BNK_ADDR        equ  $8000
CODE_ADDR           equ  $c000
CODE_RST_SHIM_ADDR  equ  $fff0
VECTORS_ADDR        equ  $fffa
PRG_BNK_0_ADDR      equ  $10000
BNK_0_RST_ADDR      equ  $13ff0
PRG_BNK_1_ADDR      equ  $14000
BNK_1_RST_ADDR      equ  $17ff0


;------------ CHR ROM (PPU)
CHR_ROM_ADDR        equ  $4C000


;------------ PPU RAM
NAMETABLE_ADDR      equ  $2000


;------------ OAM (internal PPU)
SPRITE_BUF_ADDR     equ  $200


;------------ gamepad I/O (shift register)
GAMEPAD_1_SREG      equ  $4016


;------------ PPU_CTRL_REG flags
PPU_CTRL_NMI_BIT	equ  %10000000


;------------ PPU_MASK_REG flags
MASK_BG	equ  %00001000
MASK_SPR            equ  %00010000


;------------ gamepad flags
GAMEPAD_STROBE_BIT  equ  %00000001


;------------ general constants
PAL_SIZE            equ  32


;------------ general constants
PRG_BANK_1          equ  $0
PRG_BANK_2          equ  $1
PRG_BANK_3          equ  $2
PRG_BANK_4          equ  $3
PRG_BANK_5          equ  $4
PRG_BANK_6          equ  $5
PRG_BANK_7          equ  $6
PRG_BANK_8          equ  $7
PRG_BANK_9          equ  $8
PRG_BANK_10         equ  $9
PRG_BANK_11         equ  $a
PRG_BANK_12         equ  $b
PRG_BANK_13         equ  $c
PRG_BANK_14         equ  $d
PRG_BANK_15         equ  $e
PRG_BANK_16         equ  $f


;------------ palette colors
LIGHT_BLUE	equ  $1f
