                    seg _PrgBank0_
                    org PRG_ANK_ADDR
                    rorg PRG_BNK_0_ADDR

;------------ code


;------------ bank reset shim
                    seg _PrgBank0Shim_
	org BNK_RST_SHIM_ADDR

	InsertResetShim
