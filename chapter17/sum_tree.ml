(* 木を表す型 *)
type tree_t =
  Empty (* 空の木 *)
  | Leaf of int (* 葉 *)
  | Node of tree_t * int * tree_t (* 節 *)

let tree1 = Empty
let tree2 = Leaf (3)
let tree3 = Node (tree1, 4, tree2)
let tree4 = Node (tree2, 5, tree3)

(* 目的：木に含まれる全ての整数の和を求める *)
(* sum_tree: tree_t -> int *)
let rec sum_tree tree = match tree with
  Empty -> 0
  | Leaf (n) -> n
  | Node (left, n, right) -> n + (sum_tree left) + (sum_tree right)

let test1 = sum_tree tree1 = 0
let test2 = sum_tree tree2 = 3
let test3 = sum_tree tree3 = 7
let test4 = sum_tree tree4 = 15
