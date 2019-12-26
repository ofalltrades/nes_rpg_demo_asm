                    seg _PrgBank14_
                    org BNK_14_ADDR
                    rorg SWP_BNK_ADDR


;------------ code



;------------ bank reset shim
                    seg _PrgBank14Shim_
                    org BNK_14_RST_ADDR

                    InsertResetShim
