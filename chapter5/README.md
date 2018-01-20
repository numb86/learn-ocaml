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
