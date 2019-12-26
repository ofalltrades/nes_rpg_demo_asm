                    seg _PrgBank7_
                    org PRG_BNK_7_ADDR
                    rorg PRG_BNK_ADDR


;------------ code



;------------ bank reset shim
                    seg _PrgBank7Shim_
                    org BNK_7_RST_ADDR

                    InsertResetShim
