module type S0 = sig
  type t
  include Displayable.S0 with type t := t
  include Parsable.S0 with type t := t
end

module Tests_ = struct
  module Examples = struct
    module type S0 = sig
      type t
      include Displayable.Tests.Examples.S0 with type t := t
      include Parsable.Tests.Examples.S0 with type t := t
    end
  end

  module Testable = struct
    module type S0 = sig
      include S0
      include Representable.S0 with type t := t
      include EquatableBasic.S0 with type t := t
    end
  end

  module MakeMakers(MakeExamples: functor (M: Testable.S0) -> functor (E: Examples.S0 with type t := M.t) -> Examples.S0 with type t := M.t)(MakeTests: functor (M: Testable.S0) -> functor (E: Examples.S0 with type t := M.t) -> sig val tests: Test.t list end) = struct
    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
      open Testing
      module E = MakeExamples(M)(E)
      let test = "Stringable" >:: [
        (let module T = Displayable.Tests.Make0(M)(E) in T.test);
        (let module T = Parsable.Tests.Make0(M)(E) in T.test);
      ] @ (let module T = MakeTests(M)(E) in T.tests)
    end
  end
end
