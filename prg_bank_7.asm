                    seg _PrgBank7_
                    org BNK_7_ADDR
                    rorg SWP_BNK_ADDR


;------------ code



;------------ bank reset shim
                    seg _PrgBank7Shim_
                    org BNK_7_RST_ADDR

                    InsertResetShim
