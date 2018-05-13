(* 再帰の回数を数えるカウンタ *)
let count = ref 0

(* フィボナッチ数を求める *)
let rec fib n =
  (
    count := !count + 1;
    if n < 2 then n else fib (n - 1) + fib (n - 2)
  )
