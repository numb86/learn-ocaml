let add str1 str2 = str1 ^ str2

(* 目的：文字列のリスト lst を受け取り、その要素を前から順に全てつなげた文字列を返す *)
(* concat: string list -> string *)
let concat lst = List.fold_right add lst ""

let test1 = concat [] = ""
let test2 = concat ["a"] = "a"
let test3 = concat ["あ"; "い"] = "あい"
let test4 = concat ["あ"; ""; "いう"] = "あいう"
