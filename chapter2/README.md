# 第2章　基本的なデータ

## 2.1　整数(`int`)

```ocaml
# 3 ;;
- : int = 3
```

通常の四則演算を使用可能。

```ocaml
# 3 + 4 * 2 ;;
- : int = 11
# (3 + 4) * 2 ;;
- : int = 14
```

```ocaml
# 4 mod 3 ;;
- : int = 1
# 7 / 2 * 2 ;;
- : int = 6
```

## 2.2　実数(`float`)

```ocaml
# 3.14 ;;
- : float = 3.14
```

小数点以下が0の場合は、0は省略可能。

```ocaml
# 3. ;;
- : float = 3.
```

OCamlでは整数と実数を厳密に区別するため、整数用の命令は使えない。

```ocaml
# 3.5 * 2.0 ;;
Error: This expression has type float but an expression was expected of type
         int
```

後ろにピリオドをつけた命令を使う。

```ocaml
# 3.5 *. 2.0 ;;
- : float = 7.
```

実数にのみ、べき乗を求める関数`**`が定義されている。  
以下は`2^3`。

```ocaml
# 2. ** 3. ;;
- : float = 8.
```

無限大を表す`infinity`とマイナスの無限大を表す`neg_infinity`は、実数の一種。

```ocaml
# infinity ;;
- : float = infinity
# neg_infinity ;;
- : float = neg_infinity
```

## 2.3　文字列(`string`)

```ocaml
# "abc" ;;
- : string = "abc"
# "あいうえお" ;;
- : string = "あいうえお"
# "" ;;
- : string = ""
```

```ocaml
# "ab" ^ "c" ;;
- : string = "abc"
# "プログラミング" ^ "の" ^ "基礎" ;;
- : string = "プログラミングの基礎"
```

## 2.4　真偽値(`bool`)

```ocaml
# true ;;
- : bool = true
# false ;;
- : bool = false
```

OCamlの論理演算は3つ。  
優先順位も決められており、`not`、`&&`、`||`の順。

```ocaml
# false || not false && not false ;;
- : bool = true
```

優先順位に沿って、以下の流れで処理されている。

```
false || not false && not false
↓
false || true && true
↓
false || true
↓
true
```

```ocaml
# 3 >= 3 ;;
- : bool = true
# 3 > 3 ;;
- : bool = false
# 3 + 2 = 5 || 3 + 2 = 6 ;;
- : bool = true
```

比較演算子は全てのデータに対して使うことができ、同じ型であれば必ず比較できる。  
例えば真偽値の場合、`true`は`false`よりも大きいと定義されている。

```ocaml
# true > false ;;
- : bool = true
# false > true ;;
- : bool = false
```

違う型のデータを比較することは出来ない。

```ocaml
# 3.0 > 2 ;;
Error: This expression has type int but an expression was expected of type
         float
```
