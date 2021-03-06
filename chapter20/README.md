# 第20章　モジュールの開発

## 20.1　赤黒木

2分探索木は、左右のバランスによって探索の効率が変わる。  
バランスが悪いと、探索の効率も落ちる。  
そのような時は、木を作り変えてバランスを保つ。  
バランスが保たれた木の総称を**バランス木**と呼び、その一種として**赤黒木**がある。

赤黒木では、各節に、赤または黒の色がついている。  
そして、以下の条件を満たしている。

- 木の根から空の木に至るすべてのパスにおいて、黒い節の数は同じである
- 赤い節の子は、どちらも必ず黒である（つまり、赤い節が連続することはない）

色を持っているのは節のみなので空の木に色はないが、便宜的に黒であると考えると辻褄が合う。

以上の条件により、赤黒木はバランスを保つことになる。

赤と黒を示す型`color_t`と、それを使った赤黒木の型`rb_tree_t`を定義した。  
`rb_tree_t`は、`'a`型のキーと`'b`型の値、そして`color_t`の値を持つ。

```ocaml
(* 赤か黒かを示す型 *)
type color_t = Red | Black

(* 赤黒木の型 *)
type ('a, 'b) rb_tree_t =
  Empty (* 空の木 *)
  | Node of ('a, 'b) rb_tree_t * 'a * 'b * color_t * ('a, 'b) rb_tree_t  (* 節 *)
```

## 20.6　open文

以下のように書くと、いちいち`モジュールの名前.`をつけなくても、そのモジュールで公開している関数などを使えるようになる。

```ocaml
open モジュールの名前
```

```ocaml
(* ここで Tree というモジュールを定義しておく *)

open Tree

(* Tree.empty と書く必要がなくなる *)
(* val hoge : ('a, 'b) Tree.t = Empty *)
let hoge = empty
```
