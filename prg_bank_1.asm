                    seg _PrgBank1_
                    org PRG_BNK_1_ADDR
                    rorg PRG_BNK_ADDR


;------------ code



;------------ bank reset shim
                    seg _PrgBank1Shim_
                    org BNK_1_RST_ADDR

                    InsertResetShim
