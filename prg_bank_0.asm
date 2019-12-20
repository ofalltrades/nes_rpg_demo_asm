                    seg _PrgBank0_
                    org PRG_BNK_0_ADDR
                    rorg PRG_BNK_ADDR


;------------ code


;------------ bank reset shim
                    seg _PrgBank0Shim_
	org BNK_0_RST_ADDR

	InsertResetShim
