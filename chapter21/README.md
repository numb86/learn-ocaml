# 第21章　逐次実行

## 21.1　副作用を持つ関数

`print_string`という関数は、受け取った文字列を画面に表示する。

```ocaml
# print_string "Hello" ;;
Hello- : unit = ()
```

このように、値を受け渡す以外の作用を持つ関数のことを**副作用を持つ関数**と呼ぶ。  
副作用が持たない関数を**純粋な関数**と呼ぶ。

## 21.2　unit 型

OCamlには`unit`型という型がある。  
この型の値は1つしか無い。`()`という値で、「ユニット」と読む。

この型は、「その値に意味がない」ということを意味する。  
だから、返り値の値がユニットのときは、「何も返さない」ということを示している。  
`21.1`の`print_string`もユニットを返す。  
改行を表示する`print_newline`は、ユニットを受け取りユニットを返す。

```ocaml
# print_newline () ;;

- : unit = ()
# print_string ;;
- : string -> unit = <fun>
# print_newline ;;
- : unit -> unit = <fun>
```

## 21.3　逐次実行の構文

複数の式を順番に実行していくことを**逐次実行**という。  
次のように書く。

```
(式1; 式2; ...; 式n)
```

こうすると式1から順番に実行していく。  
式n以外の式については、その値は使われずに捨てられるため、`unit`型にするのが原則。  
そうしない場合、OCamlが警告を出す。

```ocaml
# (print_string "円周率は "; print_float 3.14; print_string " です。") ;;
円周率は 3.14 です。- : unit = ()
# (1; 2) ;;
Warning 10: this expression should have type unit.
- : int = 2
```

## 21.4　実行中の変数の表示

逐次実行の構文を使うことで、処理の途中の値を表示させることが出来る。  
デバックに役立つ。

```ocaml
(* 目的：ふたつの自然数を受け取り、その最大公約数を返す *)
(* gcd: int -> int -> int *)
let rec gcd m n =
  (print_string "m = ";
  print_int m;
  print_string ", n = ";
  print_int n;
  print_newline ();
  if n = 0
    then m
    else gcd n (m mod n))
```
