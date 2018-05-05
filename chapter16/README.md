# 第16章　情報の蓄積

再帰関数では、部分問題を特定することが重要。  
それが出来れば、まずは部分問題を独立に解き、その結果を使って全体を解くことが出来る。  
しかし、部分問題を独立して解くことが出来ないケースもある。  
本章ではそのような問題を扱う。

## 16.1　情報の欠落

例として、以下のようなプログラムを作る。

まず、`distance_t`というレコードを定義する。  
これは、「隣り合う点との距離」と「先頭からの距離の合計」を持っている。

```ocaml
type distance_t = {
  kyori: float; (* 隣り合う点との距離 *)
  total: float; (* 先頭からの距離の合計 *)
}
```

だが「先頭からの距離の合計」は最初は`0.`で、`total_distance`を使うことで自動的に入力される。

```ocaml
let lst = [
  {kyori = 0.3; total: 0.};
  {kyori = 0.9; total: 0.};
  {kyori = 1.4; total: 0.};
  {kyori = 0.8; total: 0.}
]

let test = total_distance lst = [
  {kyori = 0.3; total: 0.3};
  {kyori = 0.9; total: 1.2};
  {kyori = 1.4; total: 2.6};
  {kyori = 0.8; total: 3.4}  
]
```

この`total_distance`を作るのが、今回の題材。

デザインレシピに従ってテンプレートまで作ると、次のようになる。

```ocaml
(* 目的：先頭から、リストのなかの各点までの距離の合計を計算する *)
(* total_distance: distance_t list -> distance_t list *)
let rec total_distance lst = match lst with
  [] -> []
  | {kyori = k; total = t} :: rest -> [] (* total_distance rest *)
```

だがここからが困る。  
`total_distance rest`という形で再帰呼び出ししても、答えは出ない。  
`rest`だけ渡されても、これまでの距離の合計が分からないのだから、各要素の`total`を求めることは出来ない。

これが、「部分問題を独立して解くことが出来ない」ということである。

## 16.2　アキュムレータ

再帰呼び出しをするための情報が足りない場合、必要な情報を伝えるための引数を増やす。  
`total_distance`の例では、増やした引数を受け取る補助関数`hojo`を作ることにする。

```ocaml
(* 目的：先頭から、リストのなかの各点までの距離の合計を計算する *)
(* total0 はこれまでの距離の合計 *)
(* hojo: distance_t list -> float -> distance_t list *)
let rec hojo lst total0 = match lst with
  [] -> []
  | {kyori = k; total = t} :: rest ->
    {kyori = k; total = k +. total0} :: hojo rest (k +. total0)
```

欠落した情報を補うために`total0`という引数を導入しているが、このような引数を**アキュムレータ**と呼ぶ。

アキュムレータを使うときは、何の情報を示しているのかを、目的の次の行に書く。  
アキュムレータの働きを明示しておくことで、プログラムを作りやすくなるから。  
また、この関数をどのように呼び出すかも示してくれる。

今回の例だと、アキュムレータは「これまでの距離の合計」を示しているので、`hojo`を呼び出すときは`0.`を渡せばよいことが分かる。この値の初期値はゼロなのだから。

```ocaml
let total_distance lst = hojo lst 0.
```

これでもプログラムは動くが、`hojo`は`total_distance`を定義するための補助関数なので、局所定義する。

また、アキュムレータは他の引数と関係があるため、特定の初期値を渡さなければならない。  
今回の例だと`lst`はまだ処理していないリスト、`total0`は既に処理が終わったリストの情報、という関係性がある。  
そのため、特定の文脈に沿った処理が必要であり、そういった意味でも局所定義してしまうのが望ましい。

```ocaml
(* 目的：先頭から、リストのなかの各点までの距離の合計を計算する *)
(* total_distance: distance_t list -> distance_t list *)
let total_distance lst =
  (* 目的：先頭から、リストのなかの各点までの距離の合計を計算する *)
  (* total0 はこれまでの距離の合計 *)
  (* hojo: distance_t list -> float -> distance_t list *)
  let rec hojo lst total0 = match lst with
    [] -> []
    | {kyori = k; total = t} :: rest ->
      {kyori = k; total = k +. total0} :: hojo rest (k +. total0)
      in hojo lst 0.
```

**アキュムレータに対するデザインレシピ**

1. 情報が欠落していることが分かったら、アキュムレータを使って欠落している情報を補う
2. アキュムレータの働きを目的の次の行に明示する
3. アキュムレータを使った関数は補助関数として局所的に定義する

## 16.3　アキュムレータの活用

`14.2`で、リストの要素を右から処理していく`fold_right`を紹介したが、逆に左から処理してく`fold_left`もある。  
`List.fold_left f init lst`のように使い、`fold_right`とは`init`と`lst`の順番が逆であることに注意。

```ocaml
# List.fold_left ;;
- : ('a -> 'b -> 'a) -> 'a -> 'b list -> 'a = <fun>
# List.fold_left (^) "abc" ["1"; "2"] ;;
- : string = "abc12"
# List.fold_right (^) ["1"; "2"] "abc" ;;
- : string = "12abc"
```

自分で実装すると次のようになるが、`fold_left`における`init`は、その時点までの処理の結果を蓄積しているので、アキュムレータであるといえる。

```ocaml
(* 目的： init から開始し lst の要素の左から f を実行していく *)
(* fold_left: ('a -> 'b -> 'a) -> 'a -> 'b list -> 'a *)
let rec fold_left f init lst = match lst with
  [] -> init
  | first :: rest -> fold_left f (f init first) rest
```
