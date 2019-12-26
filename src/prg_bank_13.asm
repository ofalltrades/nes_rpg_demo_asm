                    seg _PrgBank13_
                    org BNK_13_ADDR
                    rorg SWP_BNK_ADDR


;------------ code



;------------ bank reset shim
                    seg _PrgBank13Shim_
                    org BNK_13_RST_ADDR

                    InsertResetShim
