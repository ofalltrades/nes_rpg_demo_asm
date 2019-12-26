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

| Segment           | Location | Size           | Access | Use                                                                        |
| ----------------- | -------- | -------------- | ------ | -------------------------------------------------------------------------- |
| `_ZeroPage_`      | `$0000`  | `$00FF` (256B) | rw     |                                                                            |
| `_PrgRAM_  `      | `$6000`  | `$1FFF` (8K)   | rw     | data                                                                       |
| `_Header_  `      | `$7FF0`  | `$0010` (16B)  | r      |                                                                            |
| `_PrgBank0_    `  | `$8000`  | `$4000` (16K)  | r      |                                                                            |
| `_PrgBank1_    `  | `$C000`  | `$4000` (16K)  | r      |                                                                            |
| `_PrgBank2_    `  | `$10000` | `$4000` (16K)  | r      |                                                                            |
| `_PrgBank3_    `  | `$14000` | `$4000` (16K)  | r      |                                                                            |
| `_PrgBank4_    `  | `$18000` | `$4000` (16K)  | r      |                                                                            |
| `_PrgBank5_    `  | `$1C000` | `$4000` (16K)  | r      |                                                                            |
| `_PrgBank6_    `  | `$20000` | `$4000` (16K)  | r      |                                                                            |
| `_PrgBank7_    `  | `$24000` | `$4000` (16K)  | r      |                                                                            |
| `_PrgBank8_    `  | `$28000` | `$4000` (16K)  | r      |                                                                            |
| `_PrgBank9_    `  | `$2C000` | `$4000` (16K)  | r      |                                                                            |
| `_PrgBank10_    ` | `$30000` | `$4000` (16K)  | r      |                                                                            |
| `_PrgBank11_    ` | `$34000` | `$4000` (16K)  | r      |                                                                            |
| `_PrgBank12_    ` | `$38000` | `$4000` (16K)  | r      |                                                                            |
| `_PrgBank13_    ` | `$3c000` | `$4000` (16K)  | r      |                                                                            |
| `_PrgBank14_    ` | `$40000` | `$4000` (16K)  | r      |                                                                            |
| `_PrgBank15_    ` | `$44000` | `$4000` (16K)  | r      | critical code: const data, init code, bank switching, NMI handler, vectors |
