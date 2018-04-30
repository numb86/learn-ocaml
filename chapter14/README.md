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
