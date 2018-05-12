(* 赤か黒かを示す型 *)
type color_t = Red | Black

(* 赤黒木の型 *)
type ('a, 'b) rb_tree_t =
  Empty (* 空の木 *)
  | Node of ('a, 'b) rb_tree_t * 'a * 'b * color_t * ('a, 'b) rb_tree_t  (* 節 *)
