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

引数に複数のリストが与えられ、どちらのリストも再帰する可能性がある場合は、組にしてパターンマッチする。

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

## 10.7　駅名・駅間リストからの情報の取得

メトロネットワーク最短経路問題。

必要な関数を定義した。  
`kyori_wo_hyoji`で使っている`string_of_float`は、実数を文字列に変換する関数。

```ocaml
# string_of_float ;;
- : float -> string = <fun>
# string_of_float 3.0 ;;
- : string = "3."
# string_of_float 3.1 ;;
- : string = "3.1"
```

```ocaml
(* 目的：ローマ字の駅名と ekimei_t list を受け取ると、その駅の漢字表記を返す *)
(* romaji_to_kanji: string -> ekimei_t list -> string *)
let rec romaji_to_kanji ekimei_romaji lst = match lst with
  [] -> ""
  | {romaji = r; kanji = k} :: rest ->
    if r = ekimei_romaji
      then k
      else romaji_to_kanji ekimei_romaji rest

let test1 = romaji_to_kanji "hoge" global_ekimei_list = ""
let test2 = romaji_to_kanji "yoyogiuehara" global_ekimei_list = "代々木上原"
let test3 = romaji_to_kanji "yushima" global_ekimei_list = "湯島"
```

```ocaml
(* 目的：漢字の駅名をふたつと ekikan_t list を受け取り、駅間の距離を返す *)
(* get_ekikan_kyori: string -> string -> ekikan_t list -> float *)
let rec get_ekikan_kyori eki1 eki2 lst = match lst with
  [] -> infinity
  | {kiten = ki; shuten = sh; kyori = ky} :: rest ->
    if (ki = eki1 && sh = eki2) || (ki = eki2 && sh = eki1)
      then ky
      else get_ekikan_kyori eki1 eki2 rest

let test1 = get_ekikan_kyori "東京" "表参道" global_ekikan_list = infinity
let test2 = get_ekikan_kyori "渋谷" "表参道" global_ekikan_list = 1.3
let test3 = get_ekikan_kyori "表参道" "外苑前" global_ekikan_list = 0.7
```

```ocaml
(* 目的：ローマ字の駅名をふたつ受け取り、その距離を整形した文字列で返す *)
(* kyori_wo_hyoji: string -> string -> string *)
let kyori_wo_hyoji eki1 eki2 =
  let eki_kanji1 = romaji_to_kanji eki1 global_ekimei_list in
  let eki_kanji2 = romaji_to_kanji eki2 global_ekimei_list in
  if eki_kanji1 = "" then eki1 ^ "という駅は存在しません"
  else if eki_kanji2 = "" then eki2 ^ "という駅は存在しません"
  else let ekikan = get_ekikan_kyori eki_kanji1 eki_kanji2 global_ekikan_list in
    if ekikan = infinity then eki_kanji1 ^ "駅と" ^ eki_kanji2 ^ "駅はつながっていません"
    else eki_kanji1 ^ "駅から" ^ eki_kanji2 ^ "駅までは" ^ string_of_float ekikan ^ "kmです"

let test1 = kyori_wo_hyoji "hoge" "omotesandou"
  = "hogeという駅は存在しません"
let test2 = kyori_wo_hyoji "tokyo" "omotesandou"
  = "東京駅と表参道駅はつながっていません"
let test3 = kyori_wo_hyoji "shibuya" "omotesandou"
  = "渋谷駅から表参道駅までは1.3kmです"
let test4 = kyori_wo_hyoji "omotesandou" "gaienmae"
  = "表参道駅から外苑前駅までは0.7kmです"
```
