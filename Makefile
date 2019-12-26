DASM=/Users/jake/dev_tools/nes/dasm-2.20.11-osx-x64/dasm
JOKER=joker # In case I create build tools later
EMU:=fceux
DEBUGEMU:=fceux # set up later

entryfile=main
gamename=game
listname=list

build:
				$(DASM) $(entryfile).asm -f3 -odist/$(gamename).nes -ldist/$(gamename).lst -sdist/$(gamename).sym -v3 -DVER=4

clean:
				rm -rf dist/*

run:
				$(EMU) dist/$(gamename).nes
