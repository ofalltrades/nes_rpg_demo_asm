                    seg _PrgBank13_
                    org PRG_BNK_13_ADDR
                    rorg PRG_BNK_ADDR


;------------ code



;------------ bank reset shim
                    seg _PrgBank13Shim_
	org BNK_13_RST_ADDR

	InsertResetShim
