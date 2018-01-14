(* 目的：与えられた鶴の数 tsuru と亀の数 kame に対して、足の数の合計を返す *)
(* tsurukame_no_ashi : int -> int -> int *)
let tsurukame_no_ashi tsuru kame = tsuru * 2 + kame * 4

(* テスト *)
let test1 = tsurukame_no_ashi 0 1 = 4
let test2 = tsurukame_no_ashi 2 2 = 12
let test3 = tsurukame_no_ashi 3 4 = 22
