# 第5章　条件分岐

## 5.2　条件分岐の構文

場合分けを行うにはif文を使う。

```
if 条件 then 式 else 式
```

条件が`true`だった場合は`then`の後ろの式を、`false`だった場合は`else`の後ろの式を実行する。

条件の型は`bool`でなければならない。  
また、2つの式は同じ型でなければならない。

```ocaml
# if true then 1 else 2 ;;
- : int = 1
# if false then 1 else 2 ;;
- : int = 2
# if 2 < 1 then false else true ;;
- : bool = true
```

```ocaml
# if "a" then 1 else 2 ;;
Error: This expression has type string but an expression was expected of type
         bool
```

```ocaml
# if true then 1 else "2" ;;
Error: This expression has type string but an expression was expected of type
         int
```

## 5.4　式としてのif文

if文は他の式のなかに埋め込んで使うことが出来る。

```ocaml
# 2 * (if false then 2 else 3) ;;
- : int = 6
```

## 5.5　条件分岐に対するデザインレシピ

条件分岐のある関数をつくる際の手順。

1. 4.6の「関数定義に対するデザインレシピ」に沿って、ヘッダ（関数の目的、型、関数名と引数）を作る。
2. どのような場合分けが必要か考え、例を作る。境界例についても同様。そしてそれを、テストプログラムに落とし込む。
3. if文の条件の部分を作成。thenとelseの部分には、型のあった適当な値を入れておく。
4. if文のthenとelseの部分を作成。
5. テストが全てパスするかを確認。

### 実数を受け取りその絶対値を返す関数`abs_value`の場合

ヘッダを作成。

```ocaml
(* 目的：実数 x の絶対値を返す *)
(* abs_value: float -> float *)
let abs_value x = 0.0
```

テストを作成。

```ocaml
let test1 = abs_value 2.8 = 2.8
let test2 = abs_value (-2.8) = 2.8
let test3 = abs_value 0.0 = 0.0
```

条件の部分を作成。

```ocaml
let abs_value x =
  if x >= 0.0 then 0.0 else 0.0
```

thenとelseの部分を作成。

```ocaml
let abs_value x =
  if x >= 0.0 then x
  else -. x
```

テストが全て通ることを確認。

```ocaml
# #use "chapter5/abs_value.ml" ;;
val abs_value : float -> float = <fun>
val test1 : bool = true
val test2 : bool = true
val test3 : bool = true
```

## 5.6　真偽値を返す関数

if文の条件の部分は`bool`型であればいいので、その部分で`bool`を返す関数を呼び出すことも可能。  
条件が複雑な場合は、そのようにするのが望ましい。  
ひとつの関数にはひとつの仕事をさせるのがよいプログラミングスタイル。  
条件の部分の関数を作る時も当然、デザインレシピに従う。
