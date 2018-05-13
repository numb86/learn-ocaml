let count = ref (-1)

(* 文字列 str を受け取り、関数が呼び出される度に一意な数字を末尾につけて返す *)
(* gensym: string -> string *)
let gensym str = (count := !count + 1; str ^ string_of_int(!count))

let test1 = gensym "a" = "a0"
let test2 = gensym "a" = "a1"
let test3 = gensym "x" = "x2"
