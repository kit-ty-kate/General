module Operators = struct
  module type S0 = sig
    type t
    include RealNumber.Operators.S0 with type t := t
  end
end

module type S0 = sig
  type t
  module O: Operators.S0 with type t := t
  include RealNumber.S0 with type t := t and module O := O
  include Traits.PredSucc.S0 with type t := t
end

module Tests_ = struct
  module Examples = struct
    module type S0 = sig
      type t
      include RealNumber.Tests.Examples.S0 with type t := t
      include Traits.PredSucc.Tests.Examples.S0 with type t := t
    end
  end

  module Testable = struct
    module type S0 = sig
      include S0
    end
  end

  module MakeMakers(MakeExamples: functor (M: Testable.S0) -> functor (E: Examples.S0 with type t := M.t) -> Examples.S0 with type t := M.t)(MakeTests: functor (M: Testable.S0) -> functor (E: Examples.S0 with type t := M.t) -> sig val tests: Test.t list end) = struct
    module Make0(M: Testable.S0)(E: Examples.S0 with type t := M.t) = struct
      open Testing
      module E = MakeExamples(M)(E)
      let test = "Integer" >:: [
        (let module T = RealNumber.Tests.Make0(M)(E) in T.test);
        (let module T = Traits.PredSucc.Tests.Make0(M)(E) in T.test);
      ] @ (let module T = MakeTests(M)(E) in T.tests)
    end
  end
end
