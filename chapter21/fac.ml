(* 目的：自然数 n の階乗を求める *)
(* Fac.f: int -> int *)
let rec f n = if n = 0
  then 1
  else n * f (n - 1)
