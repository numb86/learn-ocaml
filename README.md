[浅井健一『プログラミングの基礎』サイエンス社](http://www.saiensu.co.jp/?page=book_details&ISBN=ISBN978-4-7819-1160-1&YEAR=2007)

[著者によるサポートページ](http://pllab.is.ocha.ac.jp/~asai/book/Top.html)

OCamlのバージョンは`4.06.0`。

# セットアップ

以下の内容でセットアップした。  
[『プログラミングの基礎』を読み進めるためにMacBookにOCaml用の環境を整備した - Qiita](https://qiita.com/nrk_baby/items/c59364ff4ff8d9d97098)

まず、Homebrewでインストール。

```bash
$ brew install ocaml
```

これにより、`$ ocmal`でOCamlの対話環境が実行される。  
対話環境を終了するにはCtrl+D。

デフォルトではカーソルキーが使えないので、`rlwrap`というツールをインストールする。これもHomebrewでインストールできる。

```bash
$ brew install rlwrap
```

`$ rlwrap ocaml`で対話環境を起動すると、カーソルキーが使えるようになる。  
以下の方法でエイリアスを設定しておけば、`$ ocaml`だけでカーソルキーを使える。


1. `$ vim ~/.bash_profile`で設定ファイルを開く
2. 末尾に`alias ocaml='rlwrap ocaml'`を追記、保存して終了
3. `$ source ~/.bash_profile`で設定を反映させる

以下の方法で、文字コードをUTF-8にする。  
`$ vim ~/.ocamlinit`で設定ファイルを作成して開き、次のように記述して保存。

```
let printer ppf = Format.fprintf ppf "\"%s\"";;
#install_printer printer;;
```

これで完了。

# 対話環境について

`#`がプロンプト。  
`;;`が入力の区切りであり、これを見て、対話環境はプログラムの実行を開始する。

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

# 第3章　変数の定義

同じ情報を複数の場所に書いていたら、プログラムの構成を見直して、それを避ける。  
その方法の一つが、変数の利用。

変数の定義方法。  
変数名の先頭の文字は、アルファベットの小文字でないといけない。

```
let 変数名 = 式
```

```ocaml
# let pi = 3.14 ;;
val pi : float = 3.14
# pi ;;
- : float = 3.14
# pi *. 2.0 ;;
- : float = 6.28
```

関数型言語における変数は、基本的に書き変えることが出来ない。  
それにより、プログラムの見通しがよくなり、間違いが減り、プログラムの信頼性が高まる。

# 第4章　関数の定義

## 4.2　関数定義の構文

関数名も、変数名と同様にアルファベットの小文字で始まる必要がある。

```
let 関数名 引数 = 式
```

```ocaml
# let f x = x + 10 ;;
val f : int -> int = <fun>
# f 3 ;;
- : int = 13
```

```ocaml
# let f x y = x * x + y * y ;;
val f : int -> int -> int = <fun>
# f 3 4 ;;
- : int = 25
```

```ocaml
# let greeting name = "Hello, I am " ^ name ^ " !" ;;
val greeting : string -> string = <fun>
# greeting "Tom" ;;
- : string = "Hello, I am Tom !"
```

```ocaml
# let hyojun_taiju m = m ** 2.0 *. 2.0 ;;
val hyojun_taiju : float -> float = <fun>
# hyojun_taiju 1.75 ;;
- : float = 6.125
```

```ocaml
# let bmi m k = k /. (m ** m) ;;
val bmi : float -> float -> float = <fun>
# bmi 1.75 60.0 ;;
- : float = 22.5338119228526281
```

## 4.3　関数の型

関数にも、型がある。  
下記の`f`という関数の型は、`int -> int`。

```ocaml
# let f x = x * 3 ;;
val f : int -> int = <fun>
```

関数の場合は中身は表示されず`<fun>`とだけ表示される。

## 4.4　型推論と型チェック

OCamlは、型についての情報を入力しなくても、型を推論してくれる。  
また、期待されている正しい型のデータが使われているかチェックしてくれる（型チェック）。  
これらの特徴により、プログラム中の間違いが減り、プログラムの信頼性が高まる。

```ocaml
# let f x = x * 3 ;;
val f : int -> int = <fun>
# f 4.0 ;;
Error: This expression has type float but an expression was expected of type
         int
```

## 4.5　関数の実行方法

関数を呼び出したときに渡された値を、**実引数**という。

関数は、以下の順番で実行される。

1. 関数呼び出しを、呼び出された関数の中身に置き換える
2. 置き換えられた関数の中身の引数の部分を、実引数に置き換える
3. 変数があればそれを中身の値に置き換えていく

例として、`kyuyo`という関数を定義し、その処理の流れを確認する。

```ocaml
# let jikyu = 900 ;;
val jikyu : int = 900
# let kihonkyu = 100 ;;
val kihonkyu : int = 100
# let kyuyo hour = kihonkyu + jikyu * hour ;;
val kyuyo : int -> int = <fun>
```

上記の後に`kyuyo 8`を実行した場合、以下の流れで処理される。

```
kyuyo 8
↓
kihonkyu + jikyu * hour
↓
kihonkyu + jikyu * 8
↓
100 + jikyu * 8
↓
100 + 900 * 8
↓
100 + 7200
↓
7300
```

## 4.6　関数定義に対するデザインレシピ

OCamlでのコメントの書き方。

```ocaml
(* ここにコメントを書く *)
```

Ocamlでは、変数や関数は使う前に定義されている必要がある。

```ocaml
let y = x + 1
let x = 1
(* Error: Unbound value x *)
```

`# #use "ファイル名" ;;`とすることで、OCamlファイルを読み込める。OCamlファイルの拡張子は`.ml`。

### 関数定義に対するデザインレシピ

関数を作る際に考えるべき、守るべきポイント。

- 目的
    - 作成する関数が何をするものなのか考える。何を受け取り、何を返すのか考え、関数の型を決める。それを元に、後述の「ヘッダ」を作成する。
- 例
    - 作成する関数に望まれる、入力と出力の具体的な例を作成する。そしてそれを、実行可能なテストプログラムに落とし込む。
- 本体
    - 関数の本体を作成する。どうやって「目的」を実現させるのか考える。
- テスト
    - テストプログラムで動作確認を行う。テストがあることでプログラムの信頼性が格段に高まるので、テストは必ず書く。

** ヘッダ **

ヘッダは、関数の目的、型、関数名と引数、の3つで構成される。

```ocaml
(* 目的：働いた時間 x に応じたアルバイト代を計算する *)
(* kyuyo : int -> int *)
let kyuyo x = 0
```

最後の0は、暫定的なもの。  
この関数の返り値の型は`int`なので、`int`の値の中から任意の値を持ってきた。  
こうしておくことで、テストを実行できるようになる。

** 関数を作成する手順 **

1. まず目的を考え、それに基いてヘッダを書く。
2. 次に例を考え、それをテストプログラムに落とし込む。
3. あとは、全てのテストをパスするように本体を作っていく。
