                    seg _PrgBank5_
                    org PRG_BNK_5_ADDR
                    rorg PRG_BNK_ADDR


;------------ code



;------------ bank reset shim
                    seg _PrgBank5Shim_
                    org BNK_5_RST_ADDR

                    InsertResetShim
