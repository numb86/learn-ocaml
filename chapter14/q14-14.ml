(* 目的：文字列のリスト lst を受け取り、その要素を前から順に全てつなげた文字列を返す *)
(* concat: string list -> string *)
let concat lst = List.fold_right (^) lst ""

let test1 = concat [] = ""
let test2 = concat ["a"] = "a"
let test3 = concat ["あ"; "い"] = "あい"
let test4 = concat ["あ"; ""; "いう"] = "あいう"
