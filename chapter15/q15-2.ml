(* 目的：ふたつの自然数を受け取り、その最大公約数を返す *)
(* gcd: int -> int -> int *)
let rec gcd m n =
  if n = 0
    then m
    else gcd n (m mod n)

let test1 = gcd 6 3 = 3
let test2 = gcd 7 5 = 1 
let test3 = gcd 30 18 = 6 
let test4 = gcd 36 24 = 12 
