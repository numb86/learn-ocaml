(* 指定された型を持つ関数を定義する *)

(* 'a -> 'a *)
let f1 x = x

(* 'a -> 'b -> 'a *)
let f2 x y = x

(* 'a -> 'b -> 'b *)
let f3 x y = y

(* 'a -> ('a -> 'b) -> 'b *)
let f4 x f = f x

(* ('a -> 'b) -> ('b -> 'c) -> 'a -> 'c *)
let f5 f g x = g (f x)
