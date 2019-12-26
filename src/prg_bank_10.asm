                    seg _PrgBank10_
                    org BNK_10_ADDR
                    rorg SWP_BNK_ADDR


;------------ code



;------------ bank reset shim
                    seg _PrgBank10Shim_
                    org BNK_10_RST_ADDR

                    InsertResetShim
