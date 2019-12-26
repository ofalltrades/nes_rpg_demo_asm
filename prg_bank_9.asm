                    seg _PrgBank9_
                    org BNK_9_ADDR
                    rorg SWP_BNK_ADDR


;------------ code



;------------ bank reset shim
                    seg _PrgBank9Shim_
                    org BNK_9_RST_ADDR

                    InsertResetShim
