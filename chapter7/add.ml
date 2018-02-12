(* 目的：2つの整数の組であるpairを受け取りその要素の和を返す *)
(* add : int * int -> int *)
let add pair = match pair with
  (a, b) -> a + b

let test1 = add (0, 0) = 0
let test2 = add (3, 4) = 7
let test3 = add (3, -4) = -1
