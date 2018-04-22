(* 目的：昇順に並んでいるリスト lst に、昇順を崩さずに整数 n を挿入して返す *)
(* insert: int list -> int -> int list *)
let rec insert lst n = match lst with
  [] -> [n]
  | first :: rest -> if first > n
    then n :: lst
    else first :: (insert rest n)

let test1 = insert [] 0 = [0]
let test2 = insert [2; 3] 1 = [1; 2; 3]
let test3 = insert [2; 3] 4 = [2; 3; 4]
let test4 = insert [2; 5] 4 = [2; 4; 5]
