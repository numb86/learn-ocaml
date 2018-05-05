type distance_t = {
  kyori: float; (* 隣り合う点との距離 *)
  total: float; (* 先頭からの距離の合計 *)
}

(* 目的：先頭から、リストのなかの各点までの距離の合計を計算する *)
(* total_distance: distance_t list -> distance_t list *)
let total_distance lst =
  (* 目的：先頭から、リストのなかの各点までの距離の合計を計算する *)
  (* total0 はこれまでの距離の合計 *)
  (* hojo: distance_t list -> float -> distance_t list *)
  let rec hojo lst total0 = match lst with
    [] -> []
    | {kyori = k; total = t} :: rest ->
      {kyori = k; total = k +. total0} :: hojo rest (k +. total0)
      in hojo lst 0.

let lst = [
  {kyori = 0.3; total = 0.};
  {kyori = 0.9; total = 0.};
  {kyori = 1.4; total = 0.};
  {kyori = 0.8; total = 0.}
]

let test = total_distance lst = [
  {kyori = 0.3; total = 0.3};
  {kyori = 0.9; total = 1.2};
  {kyori = 1.4; total = 2.59999999999999964};
  {kyori = 0.8; total = 3.39999999999999947}
]
