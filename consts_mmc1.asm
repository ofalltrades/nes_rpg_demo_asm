;------------ working RAM
HEADER_ADDR         equ  $7ff0


;------------ PRG ROM
SWP_BNK_ADDR        equ  $8000
CODE_ADDR           equ  $c000
BNK_0_ADDR          equ  $8000
BNK_0_RST_ADDR      equ  $bff0
BNK_1_ADDR          equ  $c000
BNK_1_RST_ADDR      equ  $fff0
BNK_2_ADDR          equ  $10000
BNK_2_RST_ADDR      equ  $13ff0
BNK_3_ADDR          equ  $14000
BNK_3_RST_ADDR      equ  $17ff0
BNK_4_ADDR          equ  $18000
BNK_4_RST_ADDR      equ  $1bff0
BNK_5_ADDR          equ  $1c000
BNK_5_RST_ADDR      equ  $1fff0
BNK_6_ADDR          equ  $20000
BNK_6_RST_ADDR      equ  $23ff0
BNK_7_ADDR          equ  $24000
BNK_7_RST_ADDR      equ  $27ff0
BNK_8_ADDR          equ  $28000
BNK_8_RST_ADDR      equ  $2bff0
BNK_9_ADDR          equ  $2c000
BNK_9_RST_ADDR      equ  $2fff0
BNK_10_ADDR         equ  $30000
BNK_10_RST_ADDR     equ  $33ff0
BNK_11_ADDR         equ  $34000
BNK_11_RST_ADDR     equ  $37ff0
BNK_12_ADDR         equ  $38000
BNK_12_RST_ADDR     equ  $3bff0
BNK_13_ADDR         equ  $3c000
BNK_13_RST_ADDR     equ  $3fff0
BNK_14_ADDR         equ  $40000
BNK_14_RST_ADDR     equ  $43ff0
BNK_15_ADDR         equ  $44000
BNK_15_RST_ADDR     equ  $47ff0


;------------ CHR ROM (PPU)
CHR_ROM_ADDR        equ  $48000


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
