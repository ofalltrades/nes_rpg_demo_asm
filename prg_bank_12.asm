                    seg _PrgBank12_
                    org BNK_12_ADDR
                    rorg SWP_BNK_ADDR


;------------ code



;------------ bank reset shim
                    seg _PrgBank12Shim_
                    org BNK_12_RST_ADDR

                    InsertResetShim
