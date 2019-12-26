                    seg _PrgBank6_
                    org PRG_BNK_6_ADDR
                    rorg PRG_BNK_ADDR


;------------ code



;------------ bank reset shim
                    seg _PrgBank6Shim_
	org BNK_6_RST_ADDR

	InsertResetShim
