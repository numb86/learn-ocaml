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
