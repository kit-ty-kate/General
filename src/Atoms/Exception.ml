#include "../Generated/Atoms/Exception.ml"

(*
(* The position of these symbols is tested below. Moving them requires fixing the tests *)
[@@@ocaml.warning "-8"]
let match_failure = lazy (let 0 = 1 in 0) (*BISECT-IGNORE*)
[@@@ocaml.warning "+8"]
let assert_failure = lazy (assert false)
(* End of symbols to not move *)
*)

module OCSL = OCamlStandard.List

module Self = struct
  type t = exn

  module OCSPE = OCamlStandard.Printexc

  let register_printer = OCSPE.register_printer

  include Equate.Poly

  exception MatchFailure = Match_failure
  exception AssertFailure = Assert_failure
  exception InvalidArgument = Invalid_argument
  exception Failure = Failure
  exception NotFound = Not_found
  exception OutOfMemory = Out_of_memory
  exception StackOverflow = Stack_overflow
  exception SysError = Sys_error
  exception EndOfFile = End_of_file
  exception DivisionByZero = Division_by_zero
  exception SysBlockedIO = Sys_blocked_io
  exception UndefinedRecursiveModule = Undefined_recursive_module

  exception Exit = OCSP.Exit

  let raise = OCSP.raise
  let raise_without_backtrace = OCSP.raise_notrace

  let invalid_argument format =
    Format.with_result
      ~f:(fun message -> raise (InvalidArgument message))
      format

  let failure format =
    Format.with_result
      ~f:(fun message -> raise (Failure message))
      format

  let to_string = OCSPE.to_string
  let repr = to_string

  let name = OCSPE.exn_slot_name

  let record_backtraces = OCSPE.record_backtrace
  let recording_backtraces = OCSPE.backtrace_status

  let most_recent_backtrace () =
    if recording_backtraces () then Some (OCSPE.get_raw_backtrace ()) else None

  let or_none x =
    try
      Some (Lazy.value x)
    with
      | _ -> None

  let failure_if condition format =
    Format.with_result
      ~f:(fun message -> if condition then raise (Failure message))
      format

  let failure_unless condition format =
    Format.with_result
      ~f:(fun message -> if OCSP.not condition then raise (Failure message))
      format
end

include Self

(*
module Tests = Tests_.Make(Self)(struct
  let equalities = [
    [Failure "foo"];
  ]

  let differences = [
    (Failure "foo", Failure "bar");
    (Failure "foo", InvalidArgument "foo");
  ]

  let representations = [
    (DivisionByZero, "Division_by_zero");
  ]

  let displays = representations
end)(struct
  open Testing

  exception TestException

  let tests = [
    "raise" >: (lazy (expect_exception ~expected:TestException (lazy (raise TestException))));
    "raise_without_backtrace" >: (lazy (expect_exception ~expected:TestException (lazy (raise_without_backtrace TestException))));
    "failure" >: (lazy (expect_exception ~expected:(Failure "Foo bar 42") (lazy (failure "Foo %s %n" "bar" 42))));
    "invalid_argument" >: (lazy (expect_exception ~expected:(Invalid_argument "Grmbl baz 43") (lazy (invalid_argument "Grmbl %s %n" "baz" 43))));
    "Aliases" >:: [
      "MatchFailure = Match_failure" >: (lazy (expect_exception ~expected:(MatchFailure ("Atoms/Exception.ml", 5, 30)) match_failure));
      "AssertFailure = Assert_failure" >: (lazy (expect_exception ~expected:(AssertFailure ("Atoms/Exception.ml", 7, 26)) assert_failure));
      "InvalidArgument = Invalid_argument" >: (lazy (expect_exception ~expected:(InvalidArgument "List.nth") (lazy (OCSL.nth [] (-1)))));
      "Failure = Failure" >: (lazy (expect_exception ~expected:(Failure "foo") (lazy (OCSP.failwith "foo"))));
      "NotFound = Not_found" >: (lazy (expect_exception ~expected:NotFound (lazy (OCSL.find (fun _ -> true) [])))); (*BISECT-IGNORE*)
      (* "OutOfMemory = Out_of_memory" >: (lazy (expect_exception ~expected:OutOfMemory (lazy ()))); *)
      "StackOverflow = Stack_overflow" >: (lazy (expect_exception ~expected:StackOverflow (lazy (let rec f x = 1 + (f x) in f 0))));
      (* "SysError = Sys_error" >: (lazy (expect_exception ~expected:SysError (lazy ()))); *)
      (* "EndOfFile = End_of_file" >: (lazy (expect_exception ~expected:EndOfFile (lazy ()))); *)
      "DivisionByZero = Division_by_zero" >: (lazy (expect_exception ~expected:DivisionByZero (lazy (1 / 0))));
      (* "SysBlockedIO = Sys_blocked_io" >: (lazy (expect_exception ~expected:SysBlockedIO (lazy ()))); *)
      (* "UndefinedRecursiveModule = Undefined_recursive_module" >: (lazy (expect_exception ~expected:UndefinedRecursiveModule (lazy ()))); *)

      "Exit = Pervasives.Exit" >: (lazy (expect_exception ~expected:Exit (lazy (raise Exit))));
    ]
  ]
end)
*)
