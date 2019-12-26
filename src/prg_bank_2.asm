                    seg _PrgBank2_
                    org BNK_2_ADDR
                    rorg SWP_BNK_ADDR


;------------ code



;------------ bank reset shim
                    seg _PrgBank2Shim_
                    org BNK_2_RST_ADDR

                    InsertResetShim
