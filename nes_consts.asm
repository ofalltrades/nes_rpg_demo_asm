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
PAL_START	equ  $3f00


;------------ APU, I/O registers
DMC_FREQ_REG	equ  $4010
PPU_OAM_DMA_REG	equ  $4014
APU_CHAN_CTRL_REG	equ  $4015
APU_FRAME_REG	equ  $4017


;------------ working RAM
HEADER_START        equ  $7ff0


;------------ PRG ROM
PRG_ROM_START       equ  $8000
VECTOR_START        equ  $fffa


;------------ CHR ROM (PPU)
CHR_ROM_START       equ  $10000


;------------ PPU RAM
NAMETABLE_START     equ  $2000


;------------ OAM (internal PPU)
SPRITE_BUF_START	equ  $200


;------------ gamepad I/O (shift register)
GAMEPAD_1_PORT      equ  $4016


;------------ PPU_CTRL_REG flags
PPU_CTRL_NMI_BIT	equ  %10000000


;------------ PPU_MASK_REG flags
MASK_BG	equ  %00001000
MASK_SPR            equ  %00010000


;------------ gamepad flags
GAMEPAD_STROBE_BIT  equ  %00000001


;------------ general constants
PAL_SIZE            equ  32


;------------ palette colors
LIGHT_BLUE	equ  $1f
