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

## 15.2　部分問題の生成

一般の再帰を行う関数の具体例として、昇順に整列するクイックソートを実装していく。

以下の流れで整列を行う。

1. 要素のなかから、基準となる要素をひとつ選ぶ
2. 残りの要素を、基準より小さいグループと大きいグループに分ける
3. それぞれのグループで整列を行う
4. 小さいグループ、基準となる要素、大きいグループ、の順に並べる

ヘッダとテストを作るところまでは、これまでのデザインレシピと変わらない。

```ocaml
(* 目的：受け取った lst をクイックソートを使って昇順に整列する *)
(* quick_sort: int list -> int list *)
let rec quick_sort lst = []

let test1 = quick_sort [] = []
let test2 = quick_sort [1] = [1]
let test3 = quick_sort [1; 2] = [1; 2]
let test4 = quick_sort [2; 1] = [1; 2]
let test5 = quick_sort [3; 5; 8; 2] = [2; 3; 5; 8]
```

テンプレートの作成から、異なってくる。

まず、自明に答えが出るケースはどのような時なのかを考え、それによって場合分けを行う。  
これが一般の再帰に対するテンプレートになる。

```ocaml
let rec quick_sort lst =
  if (* 自明に答えが出るケースの条件 *)
  then (* 自明に答えが出るケース *)
  else  (* それ以外のケース *)
```

`quick_sort`では「自明に答えが出るケース」とは「`lst`が空リストの場合」だが、このようなケースでは`if`文ではなく`match`文を使うことも出来る。

```ocaml
let rec quick_sort lst = match lst with
  [] -> [] (* 自明に答えが出るケース *)
  | first :: rest -> [] (* それ以外のケース *)
```

テンプレートが出来たので、次は本体部分を作る。

まず、部分問題を生成する必要がある。構造に従った再帰では`rest`であることが自明だったが、一般の再帰では自分で生成する必要がある。

今回の例では、基準となる要素を選び、それより小さい要素のリストと、大きい要素のリストを作る必要がある。

今回は`first`を基準として`rest`をふたつに分割することにする。  
なので、そのための仕事を行う補助関数を作る。  
基準の要素より小さい要素のリストを返す`take_less`と、大きい要素のリストを返す`take_greater`。  
まずはヘッダだけを作っておく。

```ocaml
(* 目的：lst の中から n より小さい要素のみを返す *)
(* quick_sort: int -> int list list -> int list *)
let take_less n lst = []

(* 目的：lst の中から n より大きい要素のみを返す *)
(* quick_sort: int -> int list -> int list *)
let take_greater n lst = []
```

これらの補助関数を使うと、部分問題を生成できる。

```ocaml
let rec quick_sort lst = match lst with
  [] -> [] (* 自明に答えが出るケース *)
  | first :: rest -> [] (* それ以外のケース *)
    (* take_less first rest *)
    (* take_greater first rest *)
```

最後に、部分問題の解を使って全体の解を計算する。  
小さいグループ、基準となる要素、大きいグループ、の順に並べればよいので、以下の形になる。

```ocaml
let rec quick_sort lst = match lst with
  [] -> []
  | first :: rest ->
    quick_sort (take_less first rest)
    @ [first]
    @ quick_sort (take_greater first rest)
```

## 15.3　補助関数の作成

補助関数`take_less`と`take_greater`はまだヘッダしか出来ていないので、完成させる。

```ocaml
(* 目的：lst の中から n より小さい要素のみを返す *)
(* quick_sort: int -> int list list -> int list *)
let take_less n lst = List.filter (fun x -> x < n) lst

(* 目的：lst の中から n より大きい要素のみを返す *)
(* quick_sort: int -> int list -> int list *)
let take_greater n lst = List.filter (fun x -> x > n) lst
```

これで完成だが、局所定義や関数の一般化を使って、以下のようにまとめることも出来る。

```ocaml
(* 目的：受け取った lst をクイックソートを使って昇順に整列する *)
(* quick_sort: int list -> int list *)
let rec quick_sort lst =
  let take n lst p = List.filter (fun x -> p x n) lst
  in let take_less n lst = take n lst (<)
  in let take_greater n lst = take n lst (>)
  in match lst with
  [] -> []
  | first :: rest ->
    quick_sort (take_less first rest)
    @ [first]
    @ quick_sort (take_greater first rest)
```

## 15.4　停止性の判定

再帰呼び出しの停止性を確認するのは困難で、それを判定するためのアルゴリズムは存在しない。  
ここで紹介する方法も、原理的には万能ではない。

次のふたつを満たせば、停止性を示している可能性が高い。

1. 再帰呼び出しをかける部分問題が、もとの問題よりも簡単になっている。
2. `1`を繰り返すと、有限回で、自明なケースに帰着する。

「簡単である」とは例えば、リストの長さが短くなっている、など。

## 15.5　一般の再帰に対するデザインレシピ

**一般の再帰に対するデザインレシピ**

テンプレート。  
自明に答えが出るケースはどのような時なのかを考え、それによって場合分けを行う。  

```
if (* 自明に答えが出るケースの条件 *)
then (* 自明に答えが出るケース *)
else  (* それ以外のケース *)
```

本体。  
以下の4つを考える。

1. 自明に答えが出るのはどのような場合か。
2. その場合の答えは何か。
3. 部分問題はどのように生成すればよいか。
4. 部分問題の結果から全体の結果を得るにはどうしたらよいか。

停止性について議論する。

具体的には`15.2`の`quick_sort`を作る手順で進めていく。
