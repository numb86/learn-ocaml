# 第17章　再帰的なデータ構造

## 17.1　バリアント型

いずれかひとつ、を意味するデータとして**バリアント型**がある。  
そして、バリアント型を構成する値を、**構成子**と呼ぶ。

下記では、`team_t`というバリアント型のデータ型を定義している。  
そして`Red`と`White`が構成子。

```ocaml
# type team_t = Red | White ;;
type team_t = Red | White
```

OCamlでは変数は小文字で始まり、構成子は大文字で始まるというルールがある。  
これを守らないとシンタックスエラーになる。

バリアント型は、レコード型のように`match`でその中身にアクセスできる。  
しかしバリアント型では、中身の値が何であるかは事前には分からないため、値の種類によって場合分けを行う。

```ocaml
# let team_string team = match team with Red -> "aka" | White -> "shiro" ;;
val team_string : team_t -> string = <fun>
# team_string White ;;
- : string = "shiro"
```

全てのケースを網羅しておかないと、警告が出る。

```ocaml
# let team_string team = match team with Red -> "aka" ;;
Warning 8: this pattern-matching is not exhaustive.
Here is an example of a case that is not matched:
White
val team_string : team_t -> string = <fun>
```

`構成子 of 型`と定義することで、構成子に引数を渡すことが出来る。

```ocaml
# type nengou_t = Showa of int | Heisei of int ;;
type nengou_t = Showa of int | Heisei of int
# Showa (60) ;;
- : nengou_t = Showa 60
```

パターン変数を使うことで引数にアクセスできる。

```ocaml
# let nengou_string nengou = match nengou with Showa (n) -> n + 1925 | Heisei (n) -> n + 1988 ;;
val nengou_string : nengou_t -> int = <fun>
# nengou_string (Heisei (30)) ;;
- : int = 2018
```

## 17.2　木

バリアント型は自己参照を許すので、例えば木構造を定義できる。

**木**とは、空の木、葉、節の3つからなるデータ構造。

**空の木**。  
ここでは、`Empty`という構成子で表現する。

**葉**。
木の末端で、何か一つデータを持っている。  
ここでは、整数のデータを持つことにし、`Leaf (n)`と表現する。

**節**。
木の幹がふたつに分かれている部分。その先にはまた、木がある。ここで自己参照している。  
幹も、データを持つ。ここでは整数とする。  
ここでは、`Node (left, n, right)`と表現する。  
子の数は3つ以上でも構わないが、ここでは2つとする。節の子が必ず2つである木を、**2分木**と呼ぶ。

以上を`tree_t`として定義すると、以下のようになる。

```ocaml
(* 木を表す型 *)
type tree_t =
  Empty (* 空の木 *)
  | Leaf of int (* 葉 *)
  | Node of tree_t * int * tree_t (* 節 *)
```

`Node`で自己参照している。  
その一方で`Empty`と`Leaf`は自己参照していないので、これらを種にして木を作っていくことが出来る。

## 17.3　再帰的なデータ構造に対するデザインレシピ

**再帰的なデータ構造に対するデザインレシピ**

- データ定義
    1. 入出力が再帰的なデータ構造になるときは、まず型を定義する
    2. 必ず自己参照しないケースがあることを確認する
    3. テストのためにも、データの例を作成しておく
- テンプレート
    1. `match`文を作成する
    2. 自己参照するケースが再帰呼び出しのケースに対応する
    3. 再帰呼び出しは自己参照する回数だけ書かれる

例として、木に含まれる全ての整数の和を求める`sum_tree`を作っていく。

データ定義は`17.2`で既に行ったので、例を作る。

```ocaml
let tree1 = Empty
let tree2 = Leaf (3)
let tree3 = Node (tree1, 4, tree2)
let tree4 = Node (tree2, 5, tree3)
```

次に、テストとヘッダ。

```ocaml
(* 目的：木に含まれる全ての整数の和を求める *)
(* sum_tree: tree_t -> int *)
let rec sum_tree tree = 0

let test1 = sum_tree tree1 = 0
let test2 = sum_tree tree2 = 3
let test3 = sum_tree tree3 = 7
let test4 = sum_tree tree4 = 15
```

テンプレート。  
再帰呼び出しが2回行われることに注目。

```ocaml
(* 目的：木に含まれる全ての整数の和を求める *)
(* sum_tree: tree_t -> int *)
let rec sum_tree tree = match tree with
  Empty -> 0
  | Leaf (n) -> 0
  | Node (left, n, right) -> 0 (* sum_tree left *) (* sum_tree right *)
```

あとはテストを見ながら、本体を作ればよい。

```ocaml
(* 目的：木に含まれる全ての整数の和を求める *)
(* sum_tree: tree_t -> int *)
let rec sum_tree tree = match tree with
  Empty -> 0
  | Leaf (n) -> n
  | Node (left, n, right) -> n + (sum_tree left) + (sum_tree right)
```

## 17.4　2分探索木

木を使った応用として、**2分探索木**がある。  
2分探索木とは、データに一定の規則を設けることで、探索を高速に行えるようにした2分木のこと。  
全ての節において以下のふたつの条件を満たしているものが、2分探索木になる。

1. 節の左側の木に格納されている全てのデータは、どれもその節に格納されているデータよりも小さい
2. 節の右側の木に格納されている全てのデータは、どれもその節に格納されているデータよりも大きい

2分探索を行う`search`を作ってみる。

```ocaml
(* 目的：2分探索木 tree のなかに data が含まれるかを真偽値で返す *)
(* search: tree_t -> int -> bool *)
let rec search tree data = match tree with
  Empty -> false
  | Leaf (n) -> n = data
  | Node (left, n, right) ->
    if n = data
      then true
      else if data > n then search right data else search left data
```

一般的に、2分探索木を使った探索はリストを使った探索よりも高速になる。

## 17.5　多相型の宣言

ここまで、木の値として整数を渡してきた。  
しかし木で本質なのはその構造であって、値はなんであっても構わない。  
つまり、多相型でも問題ない。  
そして、そのほうが使い勝手がよくなる。

OCamlで多相型を宣言するには、次のように書く。

```ocaml
type 'a tree_t =
  Empty (* 空の木 *)
  | Leaf of 'a (* 葉 *)
  | Node of 'a tree_t * 'a * 'a tree_t (* 節 *)
```

型の名前の前に型変数`'a`を書く。  
型変数は複数にすることも可能。

## 17.6　停止性

再帰的なデータ構造に従った再帰では、停止性は自明である。  
元のデータの一部に対して再帰呼び出ししている限り、いずれ自己参照していないケースに帰着する。
