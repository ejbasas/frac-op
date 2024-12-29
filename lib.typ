#let _sanitizer(n) = {
  if n.denominator.signum() == -1 {
    n.numerator = n.numerator * -1
    n.denominator = n.denominator * -1
  }
  n
}

#let frac(it) = {
  if type(it) == int {
    _sanitizer((numerator: it, denominator: 1))
  } else if type(it) == decimal {
    let decimal_part = str(it).match(regex("[+-]?\d+(?:[.](\d*))?")).at("captures").at(0)
    let exp = if decimal_part == none {0} else {decimal_part.len()}
    let denominator = calc.pow(10,exp)
    _sanitizer((numerator: int(it*denominator), denominator: denominator))
  } else if type(it) == dictionary and ("numerator" in it) and ("denominator" in it) {
    _sanitizer(it)
  } else if type(it) == str {
    let it = it.match(regex("^([+-]?\d+)\/([+-]?\d+)$"))
    if it == none {
      panic("not a fraction")
    } else {
      let it = it.at("captures").map(int)
      _sanitizer((numerator: it.at(0), denominator: it.at(1)))
    }
  } else {
    panic("not a fraction")
  }
}

#let _simp(n) = {
  let divider = calc.gcd(n.numerator, n.denominator)
  (
    numerator: calc.div-euclid(n.numerator, divider),
    denominator: calc.div-euclid(n.denominator, divider)
  )
}

#let simp(n) = {
  _simp(frac(n))
}

#let _sum(..args) = {
  let denominator = args.pos().map(n => n.denominator).dedup().reduce(calc.lcm)
  simp((
    numerator: args.pos().map(
      n => calc.div-euclid(denominator, n.denominator)*n.numerator
    ).sum(),
    denominator: denominator
  ))
}

#let sum(..args) = {
  let args = args.pos().map(frac).map(simp)
  _sum(..args)
}

#let _opposite(n) = {
  (numerator: n.numerator * -1, denominator: n.denominator)
}

#let opposite(n) = {
  _opposite(_simp(frac(n)))
}

#let difference(n, m) = {
  (n, m) = (n, m).map(simp)
  sum(n, _opposite(m))
}

#let _product(..args) = {
  simp((
    numerator: args.pos().map(n => n.numerator).product(),
    denominator: args.pos().map(n => n.denominator).product()
  ))
}

#let product(..args) = {
  let args = args.pos().map(frac).map(simp)
  _product(..args)
}

#let _inverse(n) = {
  (numerator: n.denominator, denominator: n.numerator)
}

#let inverse(n) = {
  _inverse(_simp(frac(n)))
}

#let division(n, m) = {
  (n, m) = (n, m).map(simp)
  _product(n, _inverse(m))
}

#let decimal(n) = {
  let n = _simp(frac(n))
  n.numerator/n.denominator
}

#let display(n, style: "inline") = {
//  $#str(n.numerator) / #str(n.denominator)$
  if n.denominator == 1 {
    n.numerator
  } else {
    eval("$" + style + "(" + str(n.numerator) + "/" + str(n.denominator) + ")$") 
  }
}
