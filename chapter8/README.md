# 第8章　レコード

## 8.1　レコードの必要性

組とは別の構造データとして、レコードがある。  
レコードとは、名前のついているデータの集まりである。  
レコードでは、構造データに含まれる各データに、名前をつけることが出来る。

組と違って、レコードでは順番は意味を持たない。

## 8.2　レコードの構文

```
{名前1 = 値1; 名前2 = 値2}
```

名前のことは「フィールド」という。

## 8.3　レコードとパターンマッチ

レコードも組と同じように、match文によってパターンマッチを使える。  
レコードのパターンは、以下の形になる。

```
{フィールド1 = パターン変数1; フィールド2 = パターン変数2}
```

例。

```ocaml
# match {a = 4; b = 5} with {a = x; b = y} -> x - y ;;
- : int = -1
```

## 8.4　そのほかの記法

本書では使用しないが、以下のような書き方も可能。

- パターン変数とフィールドは、同じ名前でも構わない
- パターンでは、不要なフィールドは省略できる
- match文を使わなくても、`レコード.フィールド`でフィールドの値にアクセスできる

```ocaml
# match {a = 4; b = 5} with {a = a} -> a ;;
- : int = 4
```

```ocaml
# let r = {a = 4} ;;
# r.a ;;
- : int = 4
```

## 8.5　ユーザによる型定義

レコードを使うためにはまずレコードの型を定義し、それが終わってから、レコードを使う関数を定義する必要がある。

`type`文を使うことで、自由に型を定義することが出来る。

```
type 新しく定義する型の名前 = その型の定義
```

レコードの型定義は、以下のように書く。

```
{フィールド1 : 型1; フィールド2 = 型2;}
```

本書では、ユーザ定義の型は全て`_t`で終わることにする。

```ocaml
# type r_t = {a: int} ;;
type r_t = { a : int; }
# let r = {a = 1} ;;
val r : r_t = {a = 1}
# r.a ;;
- : int = 1
```


## 8.6　データ定義に対するデザインレシピ

データの型はプログラムの構造に大きく影響を与える。  
だから、よく考えてデータの型を定義することが重要である。

ここでは、レコードを扱う関数の作り方を見ていく。

例として、学生のデータを受け取り、そこに成績の情報を付与して返す`hyouka`を作っていく。  
成績の判定は、80点以上ならA、70点以上ならB、60点以上ならC、60点未満ならD、とする。

まず、入力と出力のデータ構造を考える。  
既存の型で表現できないなら、自分で定義する。

今回は、学生のデータを表す`gakusei_t`という型を作る。

```ocaml
(* 学生ひとり分のデータ（名前、点数、成績）を表す型 *)
type gakusei_t = {
  namae: string;
  tensuu: int;
  seiseki: string;
}
```

次に、ヘッダ（関数の目的、型、関数名と引数）を作る。

```ocaml
(* 目的：学生のデータ gakusei を受け取り、成績を付与して返す *)
(* hyouka = gakusei_t -> gakusei_t *)
let hyouka gakusei = {namae = ""; tensuu = 0; seiseki = ""}
```

次にテスト。

```ocaml
(* テスト *)
let test1 = hyouka {namae="tanaka"; tensuu=80; seiseki=""}
  = {namae="tanaka"; tensuu=80; seiseki="A"}
let test2 = hyouka {namae="tanaka"; tensuu=70; seiseki=""}
  = {namae="tanaka"; tensuu=70; seiseki="B"}
let test3 = hyouka {namae="tanaka"; tensuu=61; seiseki=""}
  = {namae="tanaka"; tensuu=61; seiseki="C"}
let test4 = hyouka {namae="tanaka"; tensuu=60; seiseki=""}
  = {namae="tanaka"; tensuu=60; seiseki="C"}
let test5 = hyouka {namae="tanaka"; tensuu=59; seiseki=""}
  = {namae="tanaka"; tensuu=59; seiseki="D"}
let test6 = hyouka {namae="tanaka"; tensuu=50; seiseki=""}
  = {namae="tanaka"; tensuu=50; seiseki="D"}
```

次にテンプレート。  
入力に`gakusei_t`というレコードを受け取るので、それを取り出す`match`文を挿入する。

```ocaml
(* 目的：学生のデータ gakusei を受け取り、成績を付与して返す *)
(* hyouka = gakusei_t -> gakusei_t *)
let hyouka gakusei = match gakusei with
  {namae = n; tensuu = t; seiseki = s} ->
    {namae = ""; tensuu = 0; seiseki = ""}
```

次に条件分岐。  
`5.5　条件分岐に対するデザインレシピ`で書いたように、まずは条件分岐だけを書いておき、中身は型だけ合わせておけばよい。

```ocaml
(* 目的：学生のデータ gakusei を受け取り、成績を付与して返す *)
(* hyouka = gakusei_t -> gakusei_t *)
let hyouka gakusei = match gakusei with
  {namae = n; tensuu = t; seiseki = s} ->
    if t >= 80 then {namae = ""; tensuu = 0; seiseki = ""}
    else if t >= 70 then {namae = ""; tensuu = 0; seiseki = ""}
    else if t >= 60 then {namae = ""; tensuu = 0; seiseki = ""}
    else {namae = ""; tensuu = 0; seiseki = ""}
```

最後に本体を完成させ、テストが全て通ることを確認する。

```ocaml
(* 目的：学生のデータ gakusei を受け取り、成績を付与して返す *)
(* hyouka = gakusei_t -> gakusei_t *)
let hyouka gakusei = match gakusei with
  {namae = n; tensuu = t; seiseki = s} ->
    if t >= 80 then {namae = n; tensuu = t; seiseki = "A"}
    else if t >= 70 then {namae = n; tensuu = t; seiseki = "B"}
    else if t >= 60 then {namae = n; tensuu = t; seiseki = "C"}
    else {namae = n; tensuu = t; seiseki = "D"}
```

まとめると、以下のような流れになる。

1. 入出力のデータ構造を考え、必要なら自分で型を定義する
2. ヘッダを作る
3. テストを書く
4. テンプレートを作る
5. この時点でプログラムを実行し、構文に誤りがないか確認する
6. 条件分岐を作成
7. 本体を作成
8. テストが通ることを確認する

# 8.7　駅名と駅間の情報の定義

メトロネットワーク最短経路問題。

駅名の情報を格納するレコード型`ekimei_t`、`ekimei_t`を受け取り文字列として整形して返す関数`hyoji`、駅と駅の接続情報を格納するレコード型`ekikan_t`、を定義した。

```ocaml
(* 駅名の情報を格納するレコード型 *)
type ekimei_t = {
  kanji: string; (* 漢字の駅名 *)
  kana: string; (* 平仮名の駅名 *)
  romaji: string; (* ローマ字の駅名 *)
  shozoku: string; (* 所属する路線名 *)
}

(* 目的：駅名のデータ ekimei_t を受け取り、駅名の情報を文字列で返す *)
(* hyoji : ekimei_t -> string *)
let hyoji ekimei =
  match ekimei with {kanji = kanji; kana = kana; shozoku = rosenmei}
  -> rosenmei ^ ", " ^ kanji ^ "（" ^ kana ^ "）"

(* 駅と駅の接続情報を格納するレコード型 *)
type ekikan_t = {
  kiten: string; (* 起点の駅名（漢字） *)
  shuten: string; (* 終点の駅名（漢字） *)
  keiyu: string; (* 経由する路線名（漢字） *)
  kyori: float; (* 駅間の距離（km） *)
  jikan: int; (* 所要時間（分） *)
}
```
