                    seg _PrgBank2_
                    org PRG_BNK_2_ADDR
                    rorg PRG_BNK_ADDR


;------------ code



;------------ bank reset shim
                    seg _PrgBank2Shim_
	org BNK_2_RST_ADDR

	InsertResetShim
