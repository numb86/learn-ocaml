(* 目的：鶴と亀の合計の数 kazu と足の数の合計 ashi_no_kazu を受け取ると、鶴の数を返す *)
(* tsurukame : int -> int -> int *)
let tsurukame kazu ashi_no_kazu = (kazu * 4 - ashi_no_kazu) / 2

(* テスト *)
let test1 = tsurukame 2 6 = 1
let test2 = tsurukame 4 10 = 3
let test3 = tsurukame 5 16 = 2
