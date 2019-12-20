                    seg _PrgBank1_
                    org PRG_BNK_1_ADDR
                    rorg PRG_BNK_ADDR
                    ECHO "Start of bank 1, ORG", PRG_BNK_1_ADDR, ", RORG", PRG_BNK_ADDR


;------------ code


;------------ bank reset shim
                    seg _PrgBank1Shim_
	org BNK_1_RST_ADDR

	InsertResetShim
