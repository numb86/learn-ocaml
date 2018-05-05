(* 最短路問題で使う木を表す型 *) 
type ekikan_tree_t =
  Empty (* 空の木 *)
  | Node of ekikan_tree_t * (string * (string * float) list) * ekikan_tree_t (* 節 *) 
