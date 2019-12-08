;------------ palette constants
SCRN_COL_HIGH_BYTE	equ  $3f
SCRN_COL_LOW_BYTE	equ  $00
MASK_BG_BIT	equ  $08
CTRL_NMI_BIT	equ  $80

;------------ colors
LIGHT_BLUE	equ $1c

;------------ NES constants
NES_MIRR_HORIZ	equ  0

PPU_CTRL_REG	equ  $2000
PPU_MASK_REG	equ  $2001
PPU_STATUS_REG	equ  $2002
OAM_ADDR_REG	equ  $2003
OAM_DATA_REG	equ  $2004
PPU_SCROLL_REG	equ  $2005
PPU_ADDR_REG	equ  $2006
PPU_DATA_REG	equ  $2007

DMC_FREQ_REG	equ  $4010
APU_CHAN_CTRL_REG	equ  $4015
JOY_PAD_REG	equ  $4016
APU_FRAME_REG	equ  $4017


;------------ PPU_CTRL flags
