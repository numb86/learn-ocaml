(* 目的：受け取ったリスト lst に 0 が含まれているかを調べる *)
(* contain_zero: int list -> bool *)
let rec contain_zero lst =match lst with
  [] -> false
  | first :: rest -> if first = 0 then true else contain_zero rest

let test1 = contain_zero [] = false
let test1 = contain_zero [0; 2] = true
let test1 = contain_zero [1; 2] = false
let test1 = contain_zero [1; 0; 3] = true
let test1 = contain_zero [1; 2; 3] = false
