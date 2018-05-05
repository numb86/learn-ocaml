# 第18章　例外と例外処理

## 18.1　オプション型

OCamlには予め、次のようなオプション型が定義されている。

```ocaml
type 'a option = None | Some of 'a
```

`None`は、値がないことを意味する構成子。  
`Some of 'a`は、`'a`型の値が存在することを意味する構成子。

そのため、`'a option`は、「基本は`a`型の値だが、値がなくても構わない」ことを示す。  
例えば`int option`は、`int`もしくは値が存在しない、を意味する。

オプション型を使うことで、例外的な状況に対応できることがある。

```ocaml
(* 人に関する情報を格納するレコード *)
type person_t = {
  name : string; (* 名前 *)
  shincho : float; (* 身長 *)
  taiju : float; (* 体重 *)
  tsuki : int; (* 誕生月 *)
  hi : int; (* 誕生日 *) 
  ketsueki : string;	(* 血液型 *)
}

(* 目的：person_t list を受け取り、最初のA型の人のレコードをオプション型で返す *)
(* first_A: person_t list -> person_t option *)
let rec first_A lst = match lst with
  [] -> None
  | ({ketsueki = k} as first) :: rest ->
    if k = "A" then Some (first) else first_A rest
```

## 18.2　オプション型を使った例外処理

下記の`count_urikire_yasai`のように、`None`かどうかで場合分けを行い、例外処理を行うことが出来る。

```ocaml
(* 目的： yaoya_list を元にitem の値段を調べる *)
(* price: string -> (string * int) list -> int option *)
let rec price item yaoya_list = match yaoya_list with
  [] -> None
  | (yasai, nedan) :: rest -> if yasai = item then Some (nedan) else price item rest

(* 目的：野菜のリストと八百屋のリストを受け取り、八百屋に置いていない野菜の数を返す *)
(* count_urikire_yasai: string list -> (string * int) list -> int *)
let rec count_urikire_yasai yasai_list yaoya_list = match yasai_list with
  [] -> 0
  | first :: rest ->
    match price first yaoya_list with
      None -> 1 + count_urikire_yasai rest yaoya_list
      | Some (p) -> count_urikire_yasai rest yaoya_list
```

## 18.3　オプション型を使った例外処理の問題点

オプション型を使って例外処理を行うと、処理が冗長になり、プログラムの見通しが悪くなる。  
例外処理のために正常系の処理まで複雑になってしまうのは望ましくない。  
例外処理に関する記述は、正常系の処理とは分けてしまいたい。

そこで、例外処理を行うための専用の構文を使う。

## 18.4　例外処理専用の構文

OCamlには、例外処理に関する構文が3種類用意されている。

まず、例外を発生させる構文。

```ocaml
raise 例外の名前
```

例外が発生すると、その時点でプログラムの実行を一時停止する。  
発生した例外に対する例外処理の構文が用意されていなければ、プログラムは完全に終了する。

次に、新しく例外を宣言する構文。

```ocaml
exception 例外の名前
```

```ocaml
# exception Hoge ;;
exception Hoge
# raise Hoge ;;
Exception: Hoge.
```

例外は、先頭が大文字である必要がある。また、引数を受け取ることも出来る。

```ocaml
# exception Fuga of int ;;
exception Fuga of int
# raise (Fuga (33)) ;;
Exception: Fuga 33.
```

最後が、例外処理を行う構文。

```ocaml
try 式 with
  例外のパターン1 -> 式1
  | 例外のパターン2 -> 式2
  ...
  | 例外のパターンn -> 式n
```

まず、`try`の後ろの式を実行する。  
そこで例外が発生しなければ、この式の結果が、この構文全体の結果になる。`with`以降は実行されない。  
例外が発生した場合はパターンマッチを行い、マッチしたら対応する式を実行し、その結果が、構文全体の結果になる。  
マッチするものが見つからなかった場合は、さらに外側にある`try`文を探しに行く。そこでマッチするものがあれば、それを実行する。これを繰り返し、最後までマッチするものが見つからなかった場合は、プログラムの実行が終了する。
