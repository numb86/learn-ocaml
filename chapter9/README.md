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
