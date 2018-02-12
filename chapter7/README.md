# 第7章　組とパターンマッチ

## 7.1　組の構文

複数のデータを並べて一つのデータにしたものを、組という。  
要素の値を括弧でくくり、カンマで区切って表現する。  
型は、要素を`*`でつないだものになる。

```ocaml
# (1, 1) ;;
- : int * int = (1, 1)
```

異なる型を組み合わせることが出来るし、要素の数に制限はない。

```ocaml
# ("abc", true, 3.0) ;;
- : string * bool * float = ("abc", true, 3.)
```

組の要素として組を使うことも出来る。

```ocaml
# (4.5, ("abc", 9)) ;;
- : float * (string * int) = (4.5, ("abc", 9))
```

## 7.2　パターンマッチ

組のように内部に構造を持ったデータから中身を取り出すには、パターンマッチを使う。

```
match 式 with パターン -> 式
```

```ocaml
# match (4, 5) with (a, b) -> a + b ;;
- : int = 9
```

上記の`a`と`b`は、パターン変数という。

パターンとその対象になる式は、同じ型である必要がある。  
下記では、パターンは2つの整数の組なのに3つの整数の組が渡されているため、エラーになる。

```ocaml
# match (4, 5, 6) with (a, b) -> a + b ;;
Error: This pattern matches values of type 'a * 'b
       but a pattern was expected which matches values of type
         int * int * int
```

## 7.3　構造データに対するデザインレシピ

入力に構造データがある関数を作る際は、テストプログラムを書いた後、「テンプレート」を作る。  
テンプレートとは、入力データの型から必然的に決まってくる、プログラムの雛形のこと。

例えば、引数が組である場合、ほとんどのケースで、その関数は`match`から始まる。  
この`match`文のことを、テンプレートと呼ぶ。  
関数本体を作る前にテンプレートを作ってしまうことで、本体を作りやすくなる。

例として、2つの整数の組である`pair`を受け取り、その要素の和を返す関数`add`を作る工程を書く。

まずヘッダを作る。

```ocaml
(* 目的：2つの整数の組であるpairを受け取りその要素の和を返す *)
(* add : int * int -> int *)
let add pair = 0
```

次にテストを書く。

```ocaml
(* 目的：2つの整数の組であるpairを受け取りその要素の和を返す *)
(* add : int * int -> int *)
let add pair = 0

let test1 = add (0, 0) = 0
let test2 = add (3, 4) = 7
let test3 = add (3, -4) = -1
```

テストを書いたら、テンプレートを書く。  
引数が2つの整数の組であるため、パターンが2つの要素を持つ形（例えば`(a, b)`）の`match`文を使うことが、自ずと決まってくる。

```ocaml
(* 目的：2つの整数の組であるpairを受け取りその要素の和を返す *)
(* add : int * int -> int *)
let add pair = match pair with
  (a, b) -> 0

let test1 = add (0, 0) = 0
let test2 = add (3, 4) = 7
let test3 = add (3, -4) = -1
```

この時点でテストプログラムを実行して、`match`構文に誤りがないか確認する。  
もし間違っていた場合、エラーが出る。

```ocaml
# #use "chapter7/add.ml" ;;
val add : 'a * 'b -> int = <fun>
val test1 : bool = true
val test2 : bool = false
val test3 : bool = false
```

構文に誤りがないことを確認できたので、本体を作成する。

```ocaml
(* 目的：2つの整数の組であるpairを受け取りその要素の和を返す *)
(* add : int * int -> int *)
let add pair = match pair with
  (a, b) -> a + b

let test1 = add (0, 0) = 0
let test2 = add (3, 4) = 7
let test3 = add (3, -4) = -1
```

最後に、テストが全て通ることを確認して完成。

```ocaml
# #use "chapter7/add.ml" ;;
val add : int * int -> int = <fun>
val test1 : bool = true
val test2 : bool = true
val test3 : bool = true
```
