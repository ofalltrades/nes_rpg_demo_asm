                    seg _PrgBank3_
                    org PRG_BNK_3_ADDR
                    rorg PRG_BNK_ADDR


;------------ code



;------------ bank reset shim
                    seg _PrgBank3Shim_
                    org BNK_3_RST_ADDR

                    InsertResetShim
