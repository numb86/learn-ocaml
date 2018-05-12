# 第19章　モジュール

**モジュール**は、意味的につながりのある関数のまとまり。  
ライブラリや分割コンパイルの単位にもなる。

## 19.1　モジュールの構文

以下が、モジュールを宣言するための構文。

```ocaml
module モジュールの名前 = struct 本体 end
```

モジュールの名前は、大文字で始まる必要がある。

本体部分には、変数定義や関数定義などを自由に書ける。

```ocaml
# module Zahyou = struct
  let x = 3.0
  let y = 4.0
  end ;;
module Zahyou : sig val x : float val y : float end
```

`sig`と`end`で囲まれた部分が、このモジュールの**シグネチャ**。  
シグネチャには、そのモジュールで宣言されたものの型が入っている。

`モジュールの名前.変数名`で、中身にアクセスできる。

```ocaml
# Zahyou.x ;;
- : float = 3.
```

モジュールは、オブジェクト指向言語におけるオブジェクトのようなもの。

## 19.2　2分探索木のモジュール

2分探索木のモジュール`Tree`を作成した。

## 19.3　モジュールインターフェース：シグネチャ

公開する必要のない関数や変数は、モジュールの外からアクセス出来ないようにしておく。  
そのほうが保守性が高まるから。  
公開するもののみをシグネチャに書くことで、公開不要な部分はモジュールの中に隠避できる。

シグネチャの宣言。

```ocaml
module type シグネチャの名前 = sig 本体 end
```

シグネチャの名前は、大文字で始まっても小文字で始まってもどちらでもよい。

以下のように書く。

```ocaml
module type シグネチャの名前 = sig
  type 型
  val 変数名: その型
  val 関数名: その型
end
```

2分探索木のモジュールのシグネチャ`Tree_t`を作成した。

作成したシグネチャは、以下のように使う。

```ocaml
module シグネチャを持ったモジュールの名前 = (モジュール名 : シグネチャ名)
```

```ocaml
# module NewTree = (Tree: Tree_t) ;;
module NewTree : Tree_t
# Tree.empty ;;
- : ('a, 'b) Tree.t = Tree.Empty
# NewTree.empty ;;
- : ('a, 'b) NewTree.t = <abstr>
```

`abstr`となり、中身は公開されない。

## 19.4　抽象データ型

大規模なプログラムは、モジュールを組み合わせて作っていく。  
その際、モジュールに適切なシグネチャが与えられていると、開発がしやすい。

適切なシグネチャとは、使う側から見たモジュールの定義。  
インターフェースだけが定義されており、中身のことを意識せずに利用できる。  
このように、使い方のみによって規定されるデータのことを**抽象データ型**という。

抽象データ型になっていることで、シグネチャは、モジュールの説明書としての役割を果たせる。  
抽象データ型は、データの内部構造を公開していない。そのため、内部を書き換えることが出来る。シグネチャに書いてあるインターフェースさえ維持されていれば、内部を好きなように改良することが出来る。

## 19.5　そのほかのシグネチャの宣言方法

`19.3`ではまずモジュールを定義してから、その後で改めてシグネチャを制限した。  
だが一般的には、モジュールを宣言する時点でそのシグネチャも指定する。

シグネチャを先に宣言する方法と、モジュールとシグネチャを同時に宣言する方法がある。

まず、シグネチャを先に宣言する方法。

```ocaml
(* 予めシグネチャを宣言しておく *)
module モジュール名 : シグネチャ名 = struct
  モジュールの本体
end
```

次に、モジュールとシグネチャを同時に宣言する方法。

```ocaml
module モジュール名 : sig
  シグネチャの本体
end = struct
  モジュールの本体
end
```

## 19.6　ファイルの分割と分割コンパイル

モジュールとシグネチャを別々につくり、それをコンパイルして使うという方法もある。  
モジュールは`tree_c.ml`、シグネチャは`tree_c.mli`として用意した。

そうすると、以下のように定義したのと同じ意味になる。

```ocaml
module Tree_c : sig
  tree_c.mli
end = struct
  tree_c.ml
end
```

`OCamlMakefile`を用意した上で以下の内容の`Makefile`というファイルを作り、このディレクトリで`$ make top`とすると、`my-tree.top`というファイルが生成される。

```
SOURCES = tree_c.mli tree_c.ml
RESULT = my-tree
OCAMLMAKEFILE = ../ocaml-makefile-master/OCamlMakefile
include $(OCAMLMAKEFILE)
```

```
$ make top
ocamldep tree_c.mli > ._bcdi/tree_c.di
ocamldep tree_c.ml > ._d/tree_c.d
ocamlc -c tree_c.mli
ocamlc -c tree_c.ml
ocamlmktop \
				  \
				               -o my-tree.top \
				tree_c.cmo
```

このファイルを実行するとOCamlが起動し、定義したモジュールが使える状態になっている。

```
$ ./my-tree.top
        OCaml version 4.06.0

# Tree_c.empty ;;
- : ('a, 'b) Tree_c.t = <abstr>
```

`OCamlMakefile`は下記から入手した。  
https://github.com/mmottl/ocaml-makefile
