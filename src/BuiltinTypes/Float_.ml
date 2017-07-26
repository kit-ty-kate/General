include Concepts_.RealNumber_.Make0(struct
  type t = float

  let equal x y =
    OCamlStandard.Pervasives.(=) x y

  let compare x y =
    Compare.Poly.compare x y

  let zero = 0.

  let one = 1.

  let of_int x =
    OCamlStandard.Pervasives.float_of_int x

  let to_int x =
    OCamlStandard.Pervasives.int_of_float x

  let of_float x =
    x

  let to_float x =
    x

  let of_string x =
    OCamlStandard.Pervasives.float_of_string x

  let to_string x =
    OCamlStandard.Pervasives.string_of_float x

  let repr x =
    OCamlStandard.Pervasives.string_of_float x

  let add x y =
    OCamlStandard.Pervasives.(+.) x y

  let substract x y =
    OCamlStandard.Pervasives.(-.) x y

  let negate x =
    OCamlStandard.Pervasives.(~-.) x

  let multiply x y =
    OCamlStandard.Pervasives.( *. ) x y

  let divide x y =
    OCamlStandard.Pervasives.(/.) x y

  let abs x =
    OCamlStandard.Pervasives.abs_float x

  let exponentiate_negative_exponent ~exponentiate x n =
    exponentiate (divide 1. x) OCamlStandard.Pervasives.(-n)
end)
