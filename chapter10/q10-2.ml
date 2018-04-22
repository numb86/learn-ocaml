(* 目的：昇順に並んでいるリスト lst に、昇順を崩さずに整数 n を挿入して返す *)
(* insert: int list -> int -> int list *)
let rec insert lst n = match lst with
  [] -> [n]
  | first :: rest -> if first > n
    then n :: lst
    else first :: (insert rest n)

(* 目的：整数のリスト lst を、昇順に整列した返す *)
(* ins_sort: int list -> int list *)
let rec ins_sort lst = match lst with
  [] -> []
  | first :: rest -> insert (ins_sort rest) first

let test1 = ins_sort [] = []
let test2 = ins_sort [1] = [1]
let test3 = ins_sort [2; 3] = [2; 3]
let test4 = ins_sort [2; 5; 3; 4;] = [2; 3; 4; 5]
let test5 = ins_sort [7; 5; 2; 9;] = [2; 5; 7; 9]
