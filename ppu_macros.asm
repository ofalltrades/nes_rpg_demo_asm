                    MAC PPUSetAddr			; desc: set 16-bit PPU addr; args: upper byte, lower byte
                    lda #>{1}			; load upper byte into A
                    ldy #<{1}			; load lower byte into Y
                    sta PPU_ADDR_REG			; A -> $2006
                    sty PPU_ADDR_REG			; Y -> $2006
                    ENDM


                    MAC PPUSetVal			; desc: store 8-bit val in PPU data reg; args: value
                    lda #{1}			; load arg into A
                    sta PPU_DATA_REG			; A -> $2007
                    ENDM
