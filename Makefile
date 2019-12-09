DASM=/Users/jake/dev_tools/nes/dasm-2.20.11-osx-x64/dasm

build:

%.bin: %.asm
				$(DASM) $< -o$@ -f2 -oout -llist -v3 -DVER=4

clean:
				(cd dist; make clean; cd ..)
				rm -rf *.bin *.hex *.list.txt
