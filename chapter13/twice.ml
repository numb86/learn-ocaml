(* 目的：引数として受け取った関数 f を2回適用する関数 g を返す *)
(* twice: ('a -> 'a) -> 'a -> 'a *)
let twice f = let g x = f (f x) in g

let add3 x = x + 3
let add4 x = x + 4

let test1 = twice add3 7 = 13
let test2 = twice add4 2 = 10
