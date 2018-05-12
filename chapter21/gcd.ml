(* 目的：ふたつの自然数を受け取り、その最大公約数を返す *)
(* gcd: int -> int -> int *)
let rec gcd m n =
  (print_string "m = ";
  print_int m;
  print_string ", n = ";
  print_int n;
  print_newline ();
  if n = 0
    then m
    else gcd n (m mod n))

let hoge = gcd 36 24
