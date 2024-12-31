# Frac-op

Frac-op is a library for performing mathematical operations on fractions with [Typst](https://typst.app).

## Examples

```typ
#import "fractions.typ" as frac

#frac.simplify(5)

#frac.simplify("15/-21")

#frac.opposite("15/-21")

#frac.sum(2, "3/18", "5/12", "5/6")

#frac.difference("3/18", decimal("0.3"))

#frac.product("-3/18", "5/12", "5/-6")

#frac.division("3/18", "5/12")

$#frac.display("3/-18") + 3/7$

#frac.display("3/18", style: "display")

#frac.display("5/1", style: "display")

#frac.float("3/18")
```
