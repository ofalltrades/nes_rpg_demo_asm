                    seg _PrgBank4_
                    org PRG_BNK_4_ADDR
                    rorg PRG_BNK_ADDR


;------------ code



;------------ bank reset shim
                    seg _PrgBank4Shim_
	org BNK_4_RST_ADDR

	InsertResetShim
