(* 目的：n から 1 までの自然数のリストを返す *)
(* enumerate: int -> int list *)
let rec enumerate n = if n = 0 then [] else n :: (enumerate (n - 1))

(* 目的：n の約数のリストを返す *)
(* divisor: int -> int list *)
let divisor n =
  List.filter (fun x -> n mod x = 0) (enumerate n)

let test1 = divisor 6 = [6; 3; 2; 1]
let test2 = divisor 8 = [8; 4; 2; 1]

(* 目的：m 以下の完全数を全て返す *)
(* perfect: int -> int list *)
let perfect m =
  List.filter
    (fun x -> List.fold_right (+) (divisor x) 0 = x * 2 )
    (enumerate m)

let test3 = perfect 10000 = [8128; 496; 28; 6]
