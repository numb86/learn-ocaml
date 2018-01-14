(* 目的：与えられた鶴の数 tsuru に対して、足の本数を返す *)
(* tsuru_no_ashi : int -> int *)
let tsuru_no_ashi tsuru = tsuru * 2

(* テスト *)
let test1 = tsuru_no_ashi 0 = 0
let test2 = tsuru_no_ashi 1 = 2
let test3 = tsuru_no_ashi 3 = 6

(* 目的：与えられた亀の数 kame に対して、足の本数を返す *)
(* kame_no_ashi : int -> int *)
let kame_no_ashi kame = kame * 4

(* テスト *)
let test1 = kame_no_ashi 0 = 0
let test2 = kame_no_ashi 1 = 4
let test3 = kame_no_ashi 3 = 12
