(* 目的：文字列のリスト lst を受け取り、その中の要素を先頭から結合した文字列を返す *)
(* concat : string list -> string *)
let rec concat lst = match lst with
  [] -> ""
  | first :: rest -> first ^ concat rest

let test1 = concat [] = ""
let test2 = concat ["a"; "b"] = "ab"
let test3 = concat ["abc"; "d"; "ef"] = "abcdef"
