read_gamepad_1:                                                                 ; poll gamepad I/O ports until all bits are read
	lda #GAMEPAD_STROBE_BIT                                     ; %00000001 -> A
	sta GAMEPAD_1_SREG                                           ; poll gamepad I/O port; set strobe bit; reload gamepad vals into gamepad's shift reg
                    lsr                                                         ; set A = 0; shift 1 out of [0000 0001]
                    sta GAMEPAD_1_SREG                                           ; finish polling; clear strobe bit; stop reloading and freeze current vals
                    ldx #8                                                      ; loop over bits
._
                    pha                                                         ; A ->> Stack[]; save result
                    lda GAMEPAD_1_SREG                                           ; <gamepad state> -> A
                    lsr                                                         ; bit 0 -> Carry
                    pla                                                         ; <saved result> -> A; restore A
                    rol                                                         ; shift carry bit into result; Carry -> <bit 0 of result>
                    dex                                                         ; count down
                    bne ._                                                      ; branch if haven't looped for each bit
                    rts                                                         ; full polling result now in A
