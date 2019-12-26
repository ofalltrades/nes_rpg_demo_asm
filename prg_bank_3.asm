                    seg _PrgBank3_
                    org BNK_3_ADDR
                    rorg SWP_BNK_ADDR


;------------ code



;------------ bank reset shim
                    seg _PrgBank3Shim_
                    org BNK_3_RST_ADDR

                    InsertResetShim
