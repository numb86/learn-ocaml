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
