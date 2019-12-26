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
CODE_RST_ADDR       equ  $fff0
CODE_VECTORS_ADDR   equ  $fffa
PRG_BNK_0_ADDR      equ  $8000
BNK_0_RST_ADDR      equ  $bff0
PRG_BNK_1_ADDR      equ  $c000
BNK_1_RST_ADDR      equ  $fff0
PRG_BNK_2_ADDR      equ  $10000
BNK_2_RST_ADDR      equ  $13ff0
PRG_BNK_3_ADDR      equ  $14000
BNK_3_RST_ADDR      equ  $17ff0
PRG_BNK_14_ADDR     equ  $44000
BNK_14_RST_ADDR     equ  $47ff0
PRG_BNK_15_ADDR     equ  $48000
BNK_15_RST_ADDR     equ  $4bff0
VECTORS_ADDR        equ  $4bffa


;------------ CHR ROM (PPU)
CHR_ROM_ADDR        equ  $4c000


;------------ PPU RAM
NAMETABLE_ADDR      equ  $2000


;------------ OAM (internal PPU)
SPRITE_BUF_ADDR     equ  $200


;------------ gamepad I/O (shift register)
GAMEPAD_1_SREG      equ  $4016


;------------ PPU_CTRL_REG flags
PPU_CTRL_NMI_BIT	equ  %10000000


;------------ PPU_MASK_REG flags
BG_MASK	equ  %00001000
SPR_MASK            equ  %00010000


;------------ gamepad flags
GAMEPAD_STROBE_BIT  equ  %00000001


;------------ general constants
PAL_SIZE            equ  32


;------------ general constants
PRG_BANK_0          equ  0
PRG_BANK_1          equ  1
PRG_BANK_2          equ  2
PRG_BANK_3          equ  3
PRG_BANK_4          equ  4
PRG_BANK_5          equ  5
PRG_BANK_6          equ  6
PRG_BANK_7          equ  7
PRG_BANK_8          equ  8
PRG_BANK_9          equ  9
PRG_BANK_10         equ  10
PRG_BANK_11         equ  11
PRG_BANK_12         equ  12
PRG_BANK_13         equ  13
PRG_BANK_14         equ  14
PRG_BANK_15         equ  15


;------------ palette colors
LIGHT_BLUE	equ  $1f
