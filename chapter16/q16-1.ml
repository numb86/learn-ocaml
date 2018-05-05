(* hojo: int list -> int -> int list *)
(* acc はこれまでの数の合計 *)
let rec hojo lst acc = match lst with
  [] -> []
  | first :: rest -> first + acc :: hojo rest (first + acc)

(* 目的：整数のリストを受け取ったら、それまでの数の合計からなるリストを返す *)
(* sum_list: int list -> int list *)
let sum_list lst =
  (* hojo: int list -> int -> int list *)
  (* acc はこれまでの数の合計 *)
  let rec hojo lst acc = match lst with
    [] -> []
    | first :: rest -> first + acc :: hojo rest (first + acc)
      in hojo lst 0

let test1 = sum_list [] = []
let test2 = sum_list [4] = [4]
let test3 = sum_list [1; 3] = [1; 4]
let test4 = sum_list [3; 2; 1; 4] = [3; 5; 6; 10]
