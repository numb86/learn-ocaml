(* 2分探索木を表すモジュールのシグネチャ *)
module type Tree_t = sig
  type ('a, 'b) t
  val empty : ('a, 'b) t
  val insert : ('a, 'b) t -> 'a -> 'b -> ('a, 'b) t
  val search : ('a, 'b) t -> 'a -> 'b
end
