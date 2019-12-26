                    seg _PrgBank12_
                    org PRG_BNK_12_ADDR
                    rorg PRG_BNK_ADDR


;------------ code



;------------ bank reset shim
                    seg _PrgBank12Shim_
                    org BNK_12_RST_ADDR

                    InsertResetShim
