                    seg _PrgBank0_
                    org BNK_0_ADDR
                    rorg SWP_BNK_ADDR


;------------ code



;------------ bank reset shim
                    seg _PrgBank0Shim_
                    org BNK_0_RST_ADDR

                    InsertResetShim
