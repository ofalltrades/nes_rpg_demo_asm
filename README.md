A toy JRPG demo written for the NES in 6502 assembly.

##  Scope

This game is a minimal and partial implementation of a 2D JRPG game with:

- top-down view
- simple overworld
- no battles
- 4-way (but not free bidirectional) scrolling--the screen can move right, left, up, and down, but not simultaneously
- collisions
- UI state transitions
  - town
  - house
  - scene
  - inventory menu
  - overworld
- NPCs (with ability to walk around)
- dialogue box for interacting with entities like NPCs and letters
- an item to pick up

## Technical

### Memory



### Segments

| Segment          | Location      | Size           | Access | Use                                                                        |
| ---------------- | ------------- | -------------- | ------ | -------------------------------------------------------------------------- |
| `_ZeroPage_`     | `$0000-$00FF` | `$00FF` (256B) | rw     |                                                                            |
| `_PrgRAM_  `     | `$6000-$7FFF` | `$1FFF` (8K)   | rw     | data                                                                       |
| `_Header_  `     | `$7FF0-$7FFF` | `$0010` (16B)  | r      |                                                                            |
| `_PrgBank0_    ` | `$8000-$BFFF` | `$4000` (16K)  | r      |                                                                            |
| `_PrgBank1_    ` | `$8000-$BFFF` | `$4000` (16K)  | r      |                                                                            |
| `_PrgBank2_    ` | `$8000-$BFFF` | `$4000` (16K)  | r      |                                                                            |
| `_PrgBank3_    ` | `$8000-$BFFF` | `$4000` (16K)  | r      |                                                                            |
| `_PrgBank4_    ` | `$8000-$BFFF` | `$4000` (16K)  | r      |                                                                            |
| `_PrgBank5_    ` | `$8000-$BFFF` | `$4000` (16K)  | r      |                                                                            |
| `_PrgBank6_    ` | `$8000-$BFFF` | `$4000` (16K)  | r      |                                                                            |
| `_PrgBank7_    ` | `$8000-$BFFF` | `$4000` (16K)  | r      |                                                                            |
| `_PrgBank8_    ` | `$8000-$BFFF` | `$4000` (16K)  | r      |                                                                            |
| `_PrgBank9_    ` | `$8000-$BFFF` | `$4000` (16K)  | r      |                                                                            |
| `_PrgBankA_    ` | `$8000-$BFFF` | `$4000` (16K)  | r      |                                                                            |
| `_PrgBankB_    ` | `$8000-$BFFF` | `$4000` (16K)  | r      |                                                                            |
| `_PrgBankC_    ` | `$8000-$BFFF` | `$4000` (16K)  | r      |                                                                            |
| `_PrgBankD_    ` | `$8000-$BFFF` | `$4000` (16K)  | r      |                                                                            |
| `_PrgBankE_    ` | `$8000-$BFFF` | `$4000` (16K)  | r      |                                                                            |
| `_PrgBankF_    ` | `$8000-$BFFF` | `$4000` (16K)  | r      |                                                                            |
| `_Code_    `     | `$C000-$FFFF` | `$4000` (16K)  | r      | critical code: const data, init code, bank switching, NMI handler, vectors |
| `_Vectors_ `     | `$FFFA-$FFFF` | `$0006` (6B)   | r      |                                                                            |
