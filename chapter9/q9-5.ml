(* 目的：整数のリスト lst を受け取り、その中の偶数の要素のみを含んだリストを返す *)
(* even : int list -> int list *)
let rec even lst = match lst with
  [] -> []
  | first :: rest -> if first mod 2 = 0 then first :: even rest else even rest

let test1 = even [] = []
let test2 = even [0] = [0]
let test3 = even [1] = []
let test4 = even [2] = [2]
let test5 = even [3; 4; 9] = [4]
let test6 = even [2; 3; 7; 8] = [2; 8]
