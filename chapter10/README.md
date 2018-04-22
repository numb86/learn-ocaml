# 第10章　再帰関数を使ったプログラミング

この章では、様々な再帰関数を紹介しながら、再帰関数を使ったプログラミングがどのようなものなのか見ていく。

## 10.1　関数のネスト

OCamlでは、関数呼び出しの結果を他の関数に渡すことが出来る。  
これを、関数のネストという。

```ocaml
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

let test1 = insert [] 0 = [0]
let test2 = insert [2; 3] 1 = [1; 2; 3]
let test3 = insert [2; 3] 4 = [2; 3; 4]
let test4 = insert [2; 5] 4 = [2; 4; 5]

let test5 = ins_sort [] = []
let test6 = ins_sort [1] = [1]
let test7 = ins_sort [2; 3] = [2; 3]
let test8 = ins_sort [2; 5; 3; 4;] = [2; 3; 4; 5]
let test9 = ins_sort [7; 5; 2; 9;] = [2; 5; 7; 9]
```
