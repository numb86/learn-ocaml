(* 目的：整数のリスト lst を受け取り、その長さを返す *)
(* length : int list -> int *)
let rec length lst = match lst with
  [] -> 0
  | first :: rest -> 1 + length rest

let test1 = length [] = 0
let test2 = length [2] = 1
let test3 = length [2; 3] = 2
let test2 = length [3; 0; 2; 2] = 4
