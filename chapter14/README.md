# 第14章　高階関数を使ったリスト処理

## 14.1　条件を満たす要素を取り出す関数

`List.filter`は、条件に一致した要素をリストから取り出す高階関数。

```ocaml
# List.filter ;;
- : ('a -> bool) -> 'a list -> 'a list = <fun>
```

```ocaml
let is_even x = x mod 2 = 0

(* 目的：整数のリスト lst を受け取り、その中の偶数の要素のみを含んだリストを返す *)
(* even : int list -> int list *)
let even lst = List.filter is_even lst
```

## 14.2　各要素をまとめあげる関数

`map`や`filter`のように必ずリストを返すのではなく、リストのなかの要素をまとめあげて何らかの値（リストとは限らない）を返す関数として、`fold_right`がある。

これは、空リストの場合は指定した固定の値を返し、そうでない場合はリストの先頭の要素と再帰呼び出しの結果を使って指定した操作を行う関数。

```ocaml
# List.fold_right ;;
- : ('a -> 'b -> 'b) -> 'a list -> 'b -> 'b = <fun>
```

`List.fold_right f lst init`のように、引数を3つ受け取り、左から、再帰呼び出しに対して操作を行う関数、対象のリスト、対象のリストが空リストだった場合に返す値、になる。

これは、`init`から開始し、`lst`の要素を右から順に`f`を実行していく、と言える。

```ocaml
let add str1 str2 = str1 ^ str2

(* 目的：文字列のリスト lst を受け取り、その要素を前から順に全てつなげた文字列を返す *)
(* concat: string list -> string *)
let concat lst = List.fold_right add lst ""

let test1 = concat [] = ""
let test2 = concat ["a"] = "a"
let test3 = concat ["あ"; "い"] = "あい"
let test4 = concat ["あ"; ""; "いう"] = "あいう"
```
