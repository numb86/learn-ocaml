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

## 14.3　局所関数定義

`10.3`で紹介した局所変数定義のように、関数も局所的に定義できる。

```ocaml
(* 目的：文字列のリスト lst を受け取り、その要素を前から順に全てつなげた文字列を返す *)
(* concat: string list -> string *)
let concat lst = let add str1 str2 = str1 ^ str2 in
  List.fold_right add lst ""
```

## 14.4　名前のない関数

関数に名前をつけるのは必須ではない。  
ただし再帰関数については、名前をつけて定義しなければならない。

名前のない関数（無名関数）は以下のように定義する。

```ocaml
fun 引数 ... -> 式
```

```ocaml
# fun x -> x + x ;;
- : int -> int = <fun>
```

その場で引数を渡すと、即時実行される。

```ocaml
# (fun x -> x + x) 5 ;;
- : int = 10
```

無名関数を定義し、それに名前をつける、ということも可能。

```ocaml
# let double = fun x -> x + x ;;
val double : int -> int = <fun>
# double 4 ;;
- : int = 8
```

高階関数や無名関数を上手く使うことで、複雑な処理を簡潔に書くことが出来る。

```ocaml
(* 目的：文字列のリスト lst を受け取り、その要素を前から順に全てつなげた文字列を返す *)
(* concat: string list -> string *)
let concat lst = List.fold_right (fun str1 str2 -> str1 ^ str2) lst ""
```

## 14.5　infix 関数と prefix 関数

関数を先頭に書き、引数をその後ろに書く関数を、`prefix 関数`と呼ぶ。  
`+`のように関数を引数の間に書く関数を、`infix 関数`と呼ぶ。`+`などの演算子がそれにあたる。  
ちなみに`::`は構成子と呼ばれるもので、関数ではない。

infix 関数を`()`で括ると、prefix 関数に変換できる。

```ocaml
# (+) 3 5 ;;
- : int = 8
```

高階関数の引数として渡すときに、このテクニックが使える。

```ocaml
# let sum lst = List.fold_right (+) lst 0 ;;
val sum : int list -> int = <fun>
# sum [2; 2; 5; 1] ;;
- : int = 10
```

## 14.6　完全数を求める関数

**完全数**とは、自分自身を除く約数の和が、その数自身になる値のこと。  
例えば`6`。自分自身を除く約数（`1`,`2`,`3`）の和が`6`になる。

この節では完全数を求める関数を作っていく。

まず、約数を求める`divisor`を作る。  
それに先立ち、`n`から1までのリストを作る`enumerate`を作る。

```ocaml
(* 目的：n から 1 までの自然数のリストを返す *)
(* enumerate: int -> int list *)
let rec enumerate n = if n = 0 then [] else n :: (enumerate (n - 1))

(* 目的：n の約数のリストを返す *)
(* divisor: int -> int list *)
let divisor n =
  List.filter (fun x -> n mod x = 0) (enumerate n)
```

最後に、与えられた自然数`m`以下の完全数を全て返す`perfect`を作る。

```ocaml
(* 目的：m 以下の完全数を全て返す *)
(* perfect: int -> int list *)
let perfect m =
  List.filter
    (fun x -> List.fold_right (+) (divisor x) 0 = x * 2 )
```

高階関数を使うことで、リストをひとつのデータとして捉え、より抽象度の高い思考が出来るようになる。
