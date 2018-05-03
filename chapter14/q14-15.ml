(* 目的：n から 1 までの自然数のリストを返す *)
(* enumerate: int -> int list *)
let rec enumerate n = if n = 0 then [] else n :: (enumerate (n - 1))

(* 目的：n から 1 までの自然数の合計を返す *)
(* one_to_n: int -> int *)
let one_to_n n = List.fold_right (+) (enumerate n) 0

let test = one_to_n 5 = 15

