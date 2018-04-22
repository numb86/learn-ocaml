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

`# #use "ファイル名" ;;`とすることで、OCamlファイルを読み込める。OCamlファイルの拡張子は`.ml`。

# メトロネットワーク最短経路問題

本書では、メトロネットワーク最短経路問題を題材として扱っていく。  
これは、ふたつの駅名を与えられると、そのふたつを結ぶ最短の経路を見つけるプログラムを作ること。  
これに取り組む過程でデザインレシピ（よりよいプログラムを書くための考え方や方法論）と、コンピュータサイエンスの基礎であるデータ構造とアルゴリズムを学習するのが、本書の目的。

# 目次

第1章と第6章は省略。

## 第2章　[基本的なデータ](./chapter2)
## 第3章　[変数の定義](./chapter3)
## 第4章　[関数の定義](./chapter4)
## 第5章　[条件分岐](./chapter5)
## 第7章　[組とパターンマッチ](./chapter7)
## 第8章　[レコード](./chapter8)
## 第9章　[リスト](./chapter9)
## 第10章　[再帰関数を使ったプログラミング](./chapter10)
