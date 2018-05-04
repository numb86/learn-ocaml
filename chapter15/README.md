# 第15章　新しい形の再帰

ここまでに作ってきた再帰関数は、リストや自然数などの再帰的なデータ型の構造に従ったものだった。  
そういった関数は扱いやすく、停止性も自明であることが多い。  
この章では、構造に従わない、より一般的な再帰について見ていく。

## 15.1　再帰関数の構造

再帰関数を作るときは、以下の3つのポイントを考える必要がある。

1. 自明に答えが出る（再帰呼び出しをせずに答えを出せる）のはどのようなケースか
2. より小さな部分問題はどのようにしたら作れるか
3. 再帰呼び出しの結果を使ってどのように全体の結果を得るか

下記の`length`の場合、`[] -> 0`が`1`、`rest`が`2`、`1 + length rest`が`3`に対応している。

```ocaml
(* 目的：整数のリスト lst を受け取り、その長さを返す *)
(* length : int list -> int *)
let rec length lst = match lst with
  [] -> 0
  | first :: rest -> 1 + length rest
```

構造に従った再帰の場合、デザインレシピに沿って作れば、`3`以外は自動的に導き出される。  
だが一般的な再帰を行う関数を作る場合は、3つ全てを自分で考える必要がある。