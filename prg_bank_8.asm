                    seg _PrgBank8_
                    org BNK_8_ADDR
                    rorg SWP_BNK_ADDR


;------------ code



;------------ bank reset shim
                    seg _PrgBank8Shim_
                    org BNK_8_RST_ADDR

                    InsertResetShim
