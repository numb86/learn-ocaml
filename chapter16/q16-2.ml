(* 目的： init から開始し lst の要素の左から f を実行していく *)
(* fold_left: ('a -> 'b -> 'a) -> 'a -> 'b list -> 'a *)
let rec fold_left f init lst = match lst with
  [] -> init
  | first :: rest -> fold_left f (f init first) rest

let minimum rest_result first = if rest_result > first then first else rest_result

let test1 = fold_left minimum max_int [3; 2; 8] = 2
let test2 = fold_left (^) "abc" ["1"; "2"] = "abc12"
