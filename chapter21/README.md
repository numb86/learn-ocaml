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

## 21.5　実行の順序

OCamlでは、式を右から実行する。

副作用を持つ関数を使うときには、プログラムの実行順序を考慮する必要がある。  
実行順序に依存するプログラムは可能な限り避けるのが正しい。

## 21.6　スタンドアローンのプログラム

OCamlのインタプリタを使わず独立して動くプログラムを作る。

まず**メインファイル**を作り、それが`SOURCES`の最後に来る`Makefile`を作ってコンパイルする。

メインファイルの最後で**メイン関数**を定義し、それを呼び出す。  
そうすると、コンパイルして出来たファイルを実行したときにメイン関数が実行される。

```ocaml
(* メイン関数 *)
(* main: unit -> unit *)
let main () = (* ここにメイン関数の定義を書く *)

(* メイン関数の呼び出し *)
let _ = main ()
```

今回はメインファイルとして`main.ml`を定義し、それをコンパイルするための`Makefile`を作った。  
また、メイン関数で用いるモジュールとして`fac.ml`を定義した。  

出来上がったプログラムが、`fac`。  
以下がその実行結果。

```
$ chapter21/fac
10の階乗は 3628800 です。
```

## 21.7　引数の渡し方

`main.ml`を改良して、引数を受け取れるようにする。

`Sys.argv.(n)`で、n番目の引数を受け取ることが出来る。  
渡される値は文字列なので、整数として扱いときは`int_of_string`を使う。

```ocaml
(* メイン関数 *)
(* main: int -> unit *)
let main n = let kekka = Fac.f n in
  (
    print_int n;
    print_string " の階乗は ";
    print_int kekka;
    print_string " です。";
    print_newline ();
  )

let _ = main (int_of_string Sys.argv.(1))
```

```bash
$ chapter21/fac 5
5 の階乗は 120 です。
```
