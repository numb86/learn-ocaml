(* 木を表す型 *)
type tree_t =
  Empty (* 空の木 *)
  | Leaf of int (* 葉 *)
  | Node of tree_t * int * tree_t (* 節 *)

(* 2分探索木の例 *)
let tree1 = Empty
let tree2 = Leaf (3)
let tree3 = Node (Leaf (1), 2, Leaf (3))
let tree4 = Node (Empty, 7, Leaf (9))
let tree5 = Node (tree3, 6, tree4)

(* 目的：2分探索木 tree のなかに data が含まれるかを真偽値で返す *)
(* search: tree_t -> int -> bool *)
let rec search tree data = match tree with
  Empty -> false
  | Leaf (n) -> n = data
  | Node (left, n, right) ->
    if n = data
      then true
      else if data > n then search right data else search left data

let test1 = search tree1 3 = false
let test2 = search tree2 3 = true
let test3 = search tree2 4 = false
let test4 = search tree4 3 = false
let test5 = search tree5 1 = true
let test6 = search tree5 6 = true
let test7 = search tree5 7 = true
let test8 = search tree5 4 = false
