clear_ram:	subroutine			; clear CPU-accessible RAM
	txa			; 0 -> A; X is still 0 from inx setting it in NESInit
.clear
	sta $000,x			; 0 -> [$0 + X]
	cpx #$fe 			; set Carry flag if (X >= 254)
	bcs .without_stack			; don't clear stack
	sta $100,x			; 0 -> [$100 + X]; stack is $100-$1FF
.without_stack
	sta $200,x			; 0 -> [$200 + X]
	sta $300,x			; 0 -> [$300 + X]
	sta $400,x			; 0 -> [$400 + X]
	sta $500,x			; 0 -> [$500 + X]
	sta $600,x			; 0 -> [$600 + X]
	sta $700,x			; 0 -> [$700 + X]
	inx
	bne .clear 			; loop until X = 0
	rts
