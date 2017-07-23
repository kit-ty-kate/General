module Basic = struct
  type t = int

  let equal x y =
    Pervasives.(=) x y

  let compare x y =
    Compare.Poly.compare x y

  let zero = 0

  let one = 1

  let of_int x =
    x

  let to_int x =
    x

  let of_float x =
    Pervasives.int_of_float x

  let to_float x =
    Pervasives.float_of_int x

  let of_string x =
    Pervasives.int_of_string x

  let repr x =
    Pervasives.string_of_int x

  let add x y =
    Pervasives.(+) x y

  let substract x y =
    Pervasives.(-) x y

  let negate x =
    Pervasives.(~-) x

  let multiply x y =
    Pervasives.( * ) x y

  let divide x y =
    Pervasives.(/) x y

  let abs x =
    Pervasives.abs x
end

module Self = Concepts.Numbers.Integer.Make0(Basic)

module Examples = struct
  let repr = [
    (-3, "-3");
    (-0, "0");
    (0, "0");
    (1, "1");
    (15, "15");
  ]

  let equal = [
    [0];
    [1];
    [2];
  ]

  let different = [
    (0, 1);
    (1, -1);
  ]

  let ordered = [
    [-10; -5; -1; 0; 1; 2; 5];
  ]

  let add_substract = [
    (4, 3, 7);
    (4, -2, 2);
    (5, -7, -2);
  ]

  let negate = [
    (4, -4);
    (-7, 7);
  ]

  let multiply = [
    (4, 3, 12);
    (4, -3, -12);
    (-4, -3, 12);
  ]

  let divide = [
    (5, 2, 2);
    (4, 2, 2);
    (4, 3, 1);
    (4, 4, 1);
    (4, 5, 0);
  ]
end

let test = Testing.("Int" >:: [
  (let module T = Concepts.Numbers.Integer.Tests.Make0(Self)(Examples) in T.test);
])

include Self
