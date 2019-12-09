;------------ general constants
PAL_SIZE            equ  32


;------------ segment locations
HEADER_START        equ  $7ff0
PRG_ROM_START       equ  $8000
VECTOR_START        equ  $fffa
CHR_ROM_START       equ  $10000


;------------ palette constants
PAL_START	equ  $3f00
NAMETABLE_A_START   equ  $2000
NAMETABLE_B_START   equ  $2400


;------------ palette colors
LIGHT_BLUE	equ  $1f


;------------ nametable constants
NAMETABLE_START   equ  $2000


;------------ NES registers
PPU_CTRL_REG	equ  $2000
PPU_MASK_REG	equ  $2001
PPU_STATUS_REG	equ  $2002
OAM_ADDR_REG	equ  $2003
OAM_DATA_REG	equ  $2004
PPU_SCROLL_REG	equ  $2005
PPU_ADDR_REG	equ  $2006
PPU_DATA_REG	equ  $2007

DMC_FREQ_REG	equ  $4010
PPU_OAM_DMA_REG	equ  $4014
APU_CHAN_CTRL_REG	equ  $4015
APU_FRAME_REG	equ  $4017


;------------ PPU_CTRL_REG flags
CTRL_NMI_BIT	equ  %10000000


;------------ PPU_MASK_REG flags
MASK_BG	equ  %00001000
MASK_SPR            equ  %00010000


;------------ OAM
SPRITE_BUF_START	equ  $200


;------------ gamepad I/O
GAMEPAD_1_REG       equ  $4016
GAMEPAD_STROBE_BIT  equ  %00000001
