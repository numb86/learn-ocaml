(* 2分探索木を表すモジュール *)
module Tree = struct
  (* 2分探索木を表す型 *)
  type ('a, 'b) t =
    Empty
    | Node of ('a, 'b) t * 'a * 'b * ('a, 'b) t

  (* 空の木 *)
  let empty = Empty

  (* 目的：tree にキーが k で値が v を挿入した木を返す *)
  (* insert: ('a, 'b) t -> 'a -> 'b -> ('a, 'b) t *)
  let rec insert tree k v = match tree with
    Empty -> Node (Empty, k, v, Empty)
    | Node (left, key, value, right) ->
      if key = k
        then Node (left, key, v, right)
        else if k < key
          then Node (insert left k v, key, value, right)
          else Node (left, key, value, insert right k v)

  (* 目的：tree の中から、k がキーの値を返す *)
  (* 見つからなかった場合は Not_found を起こす *)
  (* search: ('a, 'b) t -> 'a -> 'b *)
  let rec search tree k = match tree with
    Empty -> raise Not_found
    | Node (left, key, value, right) ->
      if key = k
        then value
        else if k < key
          then search left k else search right k

end

open Tree

(* val hoge : ('a, 'b) Tree.t = Empty *)
let hoge = empty
