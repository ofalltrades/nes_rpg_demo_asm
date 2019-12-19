mmc1_update:        subroutine
                    tax                                                         ; A is the current state of gamepad 1
                    and %00001111                                               ; D-pad mask
                    beq .return                                                 ; D-pad not pressed?
                    and [[_scroll_y + #1] << 1] | [[_scroll_x + #1] >> 1]       ; last D-pad vals; scroll_dir_table vals to orig flags
                    beq .return                                                 ; current D-pad vals same as last D-pad vals?
                    MMC1ToggleMirroring                                         ; otherwise toggle current mirroring setting
.return
                    txa                                                         ; make sure A is as we left it
                    rts
