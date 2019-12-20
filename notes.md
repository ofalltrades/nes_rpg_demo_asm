# General Notes for Project

## MMC1

*(NOTE TO SELF: May want to read https://nesdoug.com/2019/10/02/22-advanced-mapper-mmc1/ for deeper understanding)*

### Bank Map

**Fixed Bank Content Guidelines**

- init code
- main game code
- all libraries
- frequently used code

**Swappable Bank Content Guidelines**

- level data
- infrequently used code
- an entire bank for music code and data; should be swapped in before music init code is called


**Map**

| Bank    | Location | Contents     |
| ------- | -------- | ------------ |
| Bank 0  | `$10000` | title screen |
| Bank 1  | `$14000` | demo village |
| Bank 2  | `$18000` | foo          |
| Bank 3  | `$1C000` | foo          |
| Bank 4  | `$20000` | foo          |
| Bank 5  | `$24000` | foo          |
| Bank 6  | `$28000` | foo          |
| Bank 7  | `$2C000` | foo          |
| Bank 8  | `$30000` | foo          |
| Bank 9  | `$34000` | foo          |
| Bank 10 | `$38000` | foo          |
| Bank 11 | `$3C000` | foo          |
| Bank 12 | `$40000` | foo          |
| Bank 13 | `$44000` | foo          |
| Bank 14 | `$48000` | foo          |
| Bank 15 | `$C000`  | core code    |
