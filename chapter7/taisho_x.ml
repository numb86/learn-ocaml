(* 目的：平面座標 (x,y) を受け取ったら、x軸について対象な座標を返す *)
(* taisho_x : int * int -> int * int *)
let taisho_x zahyo =
  match zahyo with (x, y)
  -> (x, y * -1)

let test1 = taisho_x (0, 0) = (0, 0)
let test2 = taisho_x (2, 0) = (2, 0)
let test3 = taisho_x (3, 1) = (3, -1)
let test4 = taisho_x (2, -2) = (2, 2)
let test5 = taisho_x (-5, -10) = (-5, 10)
