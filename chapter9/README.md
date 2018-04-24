# 第9章　リスト

## 9.1　リストの構造

リストとは、同じ型のデータが任意の個数、並んだデータのこと。  
大量のデータ、任意の大きさのデータを扱うことが出来る。

最も簡単なリストは、要素が0の空のリスト。

```ocaml
# [] ;;
- : 'a list = []
```

`::`を使うことで、リストの先頭に要素を追加できる。  
これは`cons`という命令。

`1 :: []`で、空のリストの先頭に`1`を加えることになる。

```ocaml
# 1 :: [] ;;
- : int list = [1]
```

`cons`を使う時は必ず`要素 :: リスト`という構造になる。そして`cons`は右に結合する。  
だから`2 :: 1 :: []`は、まず`[1]`というリストを作り、そこに`2`という要素を結合させることになる。

```ocaml
# 2 :: 1 :: [] ;;
- : int list = [2; 1]
```

### リストの定義

`[]`はリスト。そして、`要素 :: リスト`になるものも全て、リスト。  
だから、リストの一番右側には、必ず`[]`が存在する。

`要素 :: リスト`もリストである、つまり、リストの定義の中でリストを使っている。  
このような、自分自身を使って定義されたデータ型を**再帰的なデータ型**と呼ぶ。

再帰的なデータ型を定義する際には必ず、自己参照を含まない無条件で使えるケースを含む必要がある。  
これがないとデータが作れない。  
リストの場合は空リスト`[]`がそれにあたる。

## 9.2　リストの構文と型

リストは`[要素1; 要素2; ... 要素n]`と書くことが出来る。

```ocaml
# [1; 2] ;;
- : int list = [1; 2]
# [1; 2] = 1 :: 2 :: [] ;;
- : bool = true
```

リストのなかの要素は、全て同じ型でなければならない。

要素`'a`で構成されるリストの型は、`'a list`になる。

```ocaml
# [1] ;;
- : int list = [1]
# ["a"] ;;
- : string list = ["a"]
```

```ocaml
# ["a"; 1] ;;
Error: This expression has type int but an expression was expected of type
         string
```

## 9.3　リストとパターンマッチ

リストから要素を取り出す時は、以下のパターンマッチを使う。

```
match 式 with
  パターン1 -> 式1
  | パターン2 -> 式2
  | ...
  | パターンn -> 式n
```

マッチするパターンを上から順番に探していき、見つかった時点でそのパターンの式を実行する。  
このように複数のパターンを書く場合、式は全て同じ型でなければならない。

```ocaml
# match [] with [] -> 0 | first :: rest -> first;;
- : int = 0
# match [3] with [] -> 0 | first :: rest -> first;;
- : int = 3
# match ["3"] with [] -> 0 | first :: rest -> first;;
Error: This expression has type string but an expression was expected of type
         int
# match ["3"] with [] -> "aa" | first :: rest -> first;;
- : string = "3"
```

渡された式は、必ずいずれかのパターンに一致しないといけない。  
パターンが見つからない場合は`Match_failure`というエラーになる。

```ocaml
# match [1] with [] -> 0 ;;
Warning 8: this pattern-matching is not exhaustive.
Here is an example of a case that is not matched:
_::_
Exception: Match_failure ("//toplevel//", 2, -8).
```

パターンが見つかった場合でも、パターンが見つからない可能性がある時は警告を出してくれる。  
警告が出たら対応し、事前にエラーを防ぐことが重要。

下記の例では、渡された式が空のリストであるためパターンにマッチしエラーにはならなかったが、空以外のリストが渡された場合のパターンがないため、警告が出ている。

```ocaml
# match [] with [] -> 0 ;;
Warning 8: this pattern-matching is not exhaustive.
Here is an example of a case that is not matched:
_::_
- : int = 0
```

下記では、空のリストと、要素が2つ以上のリストのケースには対応しているが、要素が1つのリストが渡されたらエラーになってしまう。  
そのため、警告が出ている。  
`_::[]`の`_`は、ワイルドカードを意味している。

```ocaml
# match [] with [] -> 0 | first :: second :: rest -> second ;;
Warning 8: this pattern-matching is not exhaustive.
Here is an example of a case that is not matched:
_::[]
- : int = 0
```

## 9.4　再帰関数

リストは長さが不定なので、リストを扱う関数を作るときは、どのような長さのリストでも対応できるようにしないといけない。

**再帰関数**にすることで、対応できる。

関数がその定義のなかで自分自身を呼び出すことを**再帰呼び出し**といい、再帰関数とは再帰呼び出しを含む関数のことである。

以下の`contain_zero`は渡されたリストに`0`が含まれるかを調べる関数だが、定義のなかで自分自身を呼び出しており、これは再帰関数である。  
再帰関数を定義する際は`let`ではなく`let rec`と書いて、再帰関数であることを明示する。

```ocaml
(* 目的：受け取ったリスト lst に 0 が含まれているかを調べる *)
(* contain_zero: int list -> bool *)
let rec contain_zero lst =match lst with
  [] -> false
  | first :: rest -> if first = 0 then true else contain_zero rest
```
再帰関数を作るときには、必ずどこかで再帰呼び出しが止まるようにする必要がある。そうしないと処理が無限に続いてしまう。

再帰関数は、再帰的なデータ型と密接に関わっている。

再帰的なデータ型には自己参照している部分があるが、そこで再帰呼び出しを行っている。  
上記の例では`contain_zero rest`がそれにあたる。

また、再帰的なデータ型には自己参照を含まず無条件で使える定義も存在するが、これが、再帰呼び出しをしないケースに対応している。  
上記の例では`[] -> false`。

## 9.5　再帰関数に対するデザインレシピ

デザインレシピに再帰的なデータ型を扱う際のポイントを加えたのが、以下。

1. 入出力のデータ構造を考え、必要なら自分で型を定義する
    - 再帰的なデータ型の場合は、自己参照している箇所とそうでない箇所をそれぞれ確認する
2. ヘッダ（関数の目的、型、関数名と引数）を作る
3. テストを書く
    - 引数がリストの場合は、リストが空であるケースを必ず含める
4. テンプレートを作る
    - 再帰的なデータ型の場合は、どのパターン変数で再帰呼び出しが出来るかを確認し、コメントとして書いておく
        - データ定義の際に確認した自己参照している箇所がそれに該当する
5. この時点でプログラムを実行し、構文に誤りがないか確認する
6. 条件分岐を作成
7. 本体を作成
    - 再帰呼び出しを行う場合、ヘッダに書いた目的を使って、再帰呼び出しの意味するところを理解する
    - 出来上がった関数が再帰関数の場合は`let`の後ろに`rec`をつける
8. テストが通ることを確認する

`q-4`の課題として以下のような`length`という関数を作ったが、OCamlには予め`List.length`という関数が用意されている。

```ocaml
(* 目的：整数のリスト lst を受け取り、その長さを返す *)
(* length : int list -> int *)
let rec length lst = match lst with
  [] -> 0
  | first :: rest -> 1 + length rest
```

```ocaml
# List.length [] ;;
- : int = 0
# List.length [2; 1; 2] ;;
- : int = 3
# List.length [0] ;;
- : int = 1
```

## 9.6　テンプレートの複合

整数のリストのような単純なリストではなく、ユーザ定義のレコードのリストのように複雑なリストの場合、テンプレートが複雑になる。

例として、`8.6`で定義したレコード型`gakusei_t`のリスト`gakusei_t list`のケースを考えてみる。  
`gakusei_t list`を受け取り、成績が`A`の人が何人いるかを返す`count_A`という関数を作る。

```ocaml
(* 学生ひとり分のデータ（名前、点数、成績）を表す型 *)
type gakusei_t = {
  namae: string;
  tensuu: int;
  seiseki: string;
}
```

複雑な型を扱う場合、まずデータの例を作って変数に入れておくと、テストプログラムを書く時などに楽になる。

```ocaml
(* gakusei_t list 型のデータの例 *)
let lst1 = []
let lst2 = [{namae = "山田"; tensuu = 70; seiseki = "B"}]
let lst3 = [
  {namae = "山田"; tensuu = 70; seiseki = "B"};
  {namae = "鈴木"; tensuu = 80; seiseki = "A"}
]
let lst4 = [
  {namae = "鈴木"; tensuu = 80; seiseki = "A"};
  {namae = "山田"; tensuu = 70; seiseki = "B"};
  {namae = "高橋"; tensuu = 85; seiseki = "A"}
]
```

デザインレシピに従って書いていくと、以下の状態になる。

```ocaml
(* 目的：学生リスト lst に含まれている成績Aの人数を返す *)
(* count_A: gakusei_t list -> int *)
let count_A lst = match lst with
  [] -> 0
  | first :: rest -> 0
```

ここまでは単純なリストのときと同じ。  
だが今回のケースでは`first`のなかの各フィールドにアクセスしたい。  
その場合、以下のように`match`文をつなげることでフィールドの値を取得できる。

```ocaml
let count_A lst = match lst with
  [] -> 0
  | first :: rest -> (match first with {namae = n; tensuu = t; seiseki = s} -> 0)
```

あるいは、パターンの中にパターンを埋め込むという方法もある。  
今回のケースでは、`first`の部分に`{namae = n; tensuu = t; seiseki = s}`と書く。

```ocaml
let count_A lst = match lst with
  [] -> 0
  | {namae = n; tensuu = t; seiseki = s} :: rest -> 0
```

この書き方でレコード全体（`first :: rest`の`first`の値）を取得したい場合は、`as`を使う。

```ocaml
let count_A lst = match lst with
  [] -> 0
  | ({namae = n; tensuu = t; seiseki = s} as first) :: rest -> 0
```

あとは条件分岐を作成し、それから本体を書けば完成。

```ocaml
(* 目的：学生リスト lst に含まれている成績Aの人数を返す *)
(* count_A: gakusei_t list -> int *)
let rec count_A lst = match lst with
  [] -> 0
  | {namae = n; tensuu = t; seiseki = s} :: rest
    -> if s = "A" then 1 + count_A rest else count_A rest
```
