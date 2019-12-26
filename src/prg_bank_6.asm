                    seg _PrgBank6_
                    org BNK_6_ADDR
                    rorg SWP_BNK_ADDR


;------------ code



;------------ bank reset shim
                    seg _PrgBank6Shim_
                    org BNK_6_RST_ADDR

                    InsertResetShim
