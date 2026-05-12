# QNum

A big-number library for Roblox incremental games. Stores values as a normalized mantissa/exponent pair so calculations stay accurate well beyond what a regular `number` can represent.

## Installation

Add to your `wally.toml`:

```toml
[dependencies]
QNum = "notiku/qnum@0.1.1"
```

Then run:

```bash
wally install
```

## Usage

```lua
local QNum = require(Path.To.QNum)

local gold = QNum.fromNumber(1500)
local reward = QNum.fromString("2.5e9")

local total = gold + reward
print(total)              --> 2.50B
print(total:Format())     --> 2.50B
print(QNum.toScientific(total)) --> 2.50e9
```

## API

### Constructors

| Function                         | Description                                                      |
| -------------------------------- | ---------------------------------------------------------------- |
| `QNum.new(mantissa?, exponent?)` | Builds a QNum from a mantissa and exponent.                      |
| `QNum.fromNumber(n)`             | Builds a QNum from a regular Roblox number.                      |
| `QNum.fromString(s)`             | Parses plain, scientific (`1.5e9`), or suffix (`2.5B`) notation. |

### Arithmetic

`add`, `sub`, `mul`, `div`, `pow` are available as static functions (`QNum.add(a, b)`), as instance methods (`a:Add(b)`), and via metamethods (`a + b`, `a - b`, `a * b`, `a / b`, `a ^ 2`).

### Comparison

`eq`, `gt`, `lt`, `gte`, `lte` — also wired up to `==`, `<`, `<=`.

### Formatting

| Function                              | Example                       |
| ------------------------------------- | ----------------------------- |
| `QNum.format(value, decimals?)`       | `1.25M`                       |
| `QNum.toScientific(value, decimals?)` | `1.25e6`                      |
| `QNum.withSuffix(value, decimals?)`   | `1.25M`                       |
| `QNum.getSuffix(index)`               | `"k"`, `"M"`, `"B"`, `"U"`, … |
| `QNum.getSuffixIndex(suffix)`         | Inverse of `getSuffix`.       |

`tostring(value)` is equivalent to `QNum.format(value)`.

### Utility

- `QNum.clone(value)`
- `QNum.normalize(value)`
- `QNum.toNumber(value)` — converts back to a regular number (may overflow for huge values)
- `QNum.zero`, `QNum.one`

## License

See [LICENSE](./LICENSE).
