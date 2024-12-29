# Frac-op

Frac-op is a library for performing mathematical operations on fractions with [Typst](https://typst.app).

## Examples

```typ
#import "fractions.typ" as frac

#frac.opposite("3/18")

#let q = frac.frac(5)
#q

#frac.inverse(q)

#frac.sum("3/18", "5/12", "5/6")

#frac.difference("3/18", "5/12")

#frac.product("3/18", "5/12", "5/6")

#frac.division("3/18", "5/12")

#frac.display(q)

#frac.display(frac.frac("3/18"))

#frac.display(frac.frac("3/18"), style: "display")

#frac.decimal("3/18")
```
