                    seg _PrgBank15_
                    org PRG_BNK_15_ADDR
                    rorg CODE_ADDR


;------------ code
                    include "code.asm"


;------------ bank reset shim
                    seg _PrgBank15Shim_
	org BNK_15_RST_ADDR

	InsertResetShim
