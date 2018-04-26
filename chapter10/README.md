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

## 10.2　リストの中の最小値を求める関数

`max_int`は、int型で表せる最大の整数。  
`min_int`は、int型で表せる最小の整数。  
具体的な値は、コンピュータによって異なる。

```ocaml
# max_int ;;
- : int = 4611686018427387903
# min_int ;;
- : int = -4611686018427387904
```

## 10.3　局所変数定義

特定の式でのみ使える変数を**局所変数**と呼ぶ。  
次のように定義する。

```
let 変数名 = 式1 in 式2
```

こうすると、この変数名は式2のなかでのみ使える。

```ocaml
# let x = 2 in 3 + x ;;
- : int = 5
# x ;;
Error: Unbound value x
```

この変数が使える範囲、変数の有効範囲を、**スコープ**と呼ぶ。

スコープの外側に同名の変数が既に定義されていても、局所変数が使われる。

```ocaml
# let x = 5 ;;
val x : int = 5
# let x = 3 in x * 2 ;;
- : int = 6
# x * 2 ;;
- : int = 10
```

局所変数定義は入れ子に出来る。

```ocaml
# let x = 1 in let y = 2 in x + y ;;
- : int = 3
# let x = 10 in let y = x - 1 in y - 1 ;;
- : int = 8
```

局所変数を使うことで、プログラム内の無駄な再計算を防ぐことが出来る。

## 10.4　パターンマッチつき局所変数定義

局所変数定義とパターンマッチを同時に行うことが出来る。

```ocaml
# let (a, b) = (2, 3) in a + b ;;
- : int = 5
```

`max`と`min`はそれぞれ、与えられた2つの値のうち大きいほうや小さいほうを返す。

```ocaml
# max 2 3 ;;
- : int = 3
# min 2 3 ;;
- : int = 2
# max 2. 3. ;;
- : float = 3.
# max "A" "C" ;;
- : string = "C"
# max true false ;;
- : bool = true
```

## 10.5　ふたつのリストを結合する関数

`List.append`は、受け取った2つのリストを結合する。  
省略記法として`@`もある。  
`リスト @ リスト`とすることで、2つのリストを結合できる。  
`::`のときは必ず`要素 :: リスト`となったが、`@`では両側にリストが来る。

```ocaml
# List.append [2] [1; 4] ;;
- : int list = [2; 1; 4]
# List.append [] [1; 4] ;;
- : int list = [1; 4]
# [2] @ [1; 4] ;;
- : int list = [2; 1; 4]
```

## 10.6　ふたつの昇順に並んだリストをマージする関数

引数に複数のリストが与えられ、どちらのリストも再起する可能性がある場合は、組にしてパターンマッチする。

```ocaml
(* 目的：ふたつのリストを受け取り、それらの長さが同じかを判定する *)
(* equal_length: 'a list -> 'a list -> bool *)
let rec equal_length lst1 lst2 = match (lst1, lst2) with
  ([], []) -> true
  | ([], first2 :: rest2) -> false
  | (first1 :: rest1, []) -> false
  | (first1 :: rest1, first2 :: rest2) ->
    equal_length rest1 rest2
```
