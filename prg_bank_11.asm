                    seg _PrgBank11_
                    org BNK_11_ADDR
                    rorg SWP_BNK_ADDR


;------------ code



;------------ bank reset shim
                    seg _PrgBank11Shim_
                    org BNK_11_RST_ADDR

                    InsertResetShim
