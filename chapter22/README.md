# 第22章　値の書き変えと参照透過性

## 22.1　参照透過性

一度作ったデータの値が変わらないことを、データが**参照透過性**を持つという。  
データの参照透過性が保たれているプログラムは、可読性が高い。

## 22.2　呼び出し回数のカウント

フィボナッチ数を求める関数`fib`がある。

```
(* フィボナッチ数を求める *)
let rec fib n =
  if n < 2 then n else fib (n - 1) + fib (n - 2)
```

この中で再帰呼び出しが行われているが、それが何回行われたかを調べたいとする。  
そのような場合は、カウンタとして使う値を書き変えるようにすると、プログラムを書きやすい。

## 22.3　参照型と値の書き変え

`ref 初期値`とすることで、変更可能なデータを作れる。変更可能なデータのことを、本書では**セル**と呼ぶ。

```ocaml
# ref 0 ;;
- : int ref = {contents = 0}
# ref "a" ;;
- : string ref = {contents = "a"}
```

型は`'a ref`で、これは参照型と呼ぶ。

値にアクセスするには`!セルの名前`とする。

```ocaml
# let hoge = ref 0 ;;
val hoge : int ref = {contents = 0}
# !hoge ;;
- : int = 0
```

値を書き変える代入文は`:=`を使って書く。

```ocaml
# hoge := 4 ;;
- : unit = ()
# !hoge ;;
- : int = 4
```

代入文そのものの値は`()`なので注意。

変更可能なのは値であり、型は初期値を作ったときに決まり変更できない。

```ocaml
# hoge := "4" ;;
Error: This expression has type string but an expression was expected of type
         int
```

`fib`を以下のように書き変えると、`count`というセルに、再帰呼び出しの回数を記録していくことが出来る。

```
(* 再帰の回数を数えるカウンタ *)
let count = ref 0

(* フィボナッチ数を求める *)
let rec fib n =
  (
    count := !count + 1;
    if n < 2 then n else fib (n - 1) + fib (n - 2)
  )
```

## 22.4　参照透過性の喪失

副作用のある関数は冪等性が保たれないため、扱う際には注意が必要。

また、参照型では「値の共有」も行われてしまうため、それにも注意しないといけない。  
下記の例では、参照型である`hoge`が`lst1`と`lst2`で使われている。  
そのため`hoge`の値が変わると、両方のリストが影響を受ける。

```ocaml
# let hoge = ref 1 ;;
val hoge : int ref = {contents = 1}
# let lst1 = [hoge] ;;
val lst1 : int ref list = [{contents = 1}]
# let lst2 = ref 2 :: lst1 ;;
val lst2 : int ref list = [{contents = 2}; {contents = 1}]
# hoge := 5 ;;
- : unit = ()
# lst1 ;;
- : int ref list = [{contents = 5}]
# lst2 ;;
- : int ref list = [{contents = 2}; {contents = 5}]
```

プログラムを書くときは極力、参照透過性が成り立つ型のみを使うようにする。  
そうすることで複雑性を排除することが出来る。

`List.iter`は、`List.map`のようにリストの各要素に関数を実行していくが、`List.map`と違ってリストを返すのではなく、実行する関数も値を返さない。

```ocaml
# List.iter ;;
- : ('a -> unit) -> 'a list -> unit = <fun>
# let fuga = [ref 1; ref 2] ;;
val fuga : int ref list = [{contents = 1}; {contents = 2}]
# let foo = ref 0 :: fuga ;;
val foo : int ref list = [{contents = 0}; {contents = 1}; {contents = 2}]
# List.iter (fun x -> x := !x + 1)  foo ;;
- : unit = ()
# fuga ;;
- : int ref list = [{contents = 2}; {contents = 3}]
# foo ;;
- : int ref list = [{contents = 1}; {contents = 2}; {contents = 3}]
```

## 22.5　変更可能なレコード

レコードの型を定義する時、フィールド名の前に`mutable`というキーワードをつけると、そのフィールドは変更可能になる。  
代入文は、`<-`を使う。

以下では`foo_t`というレコード型を定義した際に、`fuga`というフィールドを変更可能にしている。  
そのため`<-`で代入できる。  
`hoge`は変更不可能なので、代入しようとするとエラーになる。

```ocaml
# type foo_t = {hoge : int; mutable fuga : int} ;;
type foo_t = { hoge : int; mutable fuga : int; }
# let my_record = {hoge = 3; fuga = 4} ;;
val my_record : foo_t = {hoge = 3; fuga = 4}
# my_record.fuga <- 10 ;;
- : unit = ()
# my_record ;;
- : foo_t = {hoge = 3; fuga = 10}
# my_record.hoge <- 10 ;;
Error: The record field hoge is not mutable
```

## 22.6　配列

`[| 要素; 要素; ... |]`で配列を作れる。  
配列の要素は、全て同じ型でないといけない。

要素の型が`'a`のとき、配列の型は`'a array`になる。

```ocaml
# let a = [|3; 5; 6|] ;;
val a : int array = [|3; 5; 6|]
```

`Array.get 配列の名前 添字`もしくは`配列の名前.(添字)`で、要素を取得できる。  
添字は、`0`から始まる。

```ocaml
# let a = [|3; 5; 6|] ;;
val a : int array = [|3; 5; 6|]
# Array.get a 0 ;;
- : int = 3
# a.(0) ;;
- : int = 3
# a.(2) ;;
- : int = 6
# a.(3) ;;
Exception: Invalid_argument "index out of bounds".
```

## 22.7　配列の変更

配列は最初から、全ての要素が変更可能である。

`Array.set 配列の名前 添字 代入する値`もしくは`配列の名前.(添字) <- 代入する値`で変更可能。

```ocaml
# a ;;
- : int array = [|3; 5; 6|]
# Array.set a 1 8 ;;
- : unit = ()
# a ;;
- : int array = [|3; 8; 6|]
# a.(2) <- 7 ;;
- : unit = ()
# a ;;
- : int array = [|3; 8; 7|]
```

`Array.length`を使うと、配列の長さを得られる。

```ocaml
# a ;;
- : int array = [|3; 8; 7|]
# Array.length a ;;
- : int = 3
```
