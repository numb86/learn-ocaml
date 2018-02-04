(* 五教科の点数を与えられたら、その合計点と平均点の組を返す *)
(* float * float * float * float * float -> float * float *)
let goukei_to_heikin (a, b, c, d, e)
  = (a +. b +. c +. d +. e, (a +. b +. c +. d +. e) /. 5.0)

let test1 = goukei_to_heikin (100.0, 100.0, 100.0, 100.0, 100.0) = (500.0, 100.0)
let test2 = goukei_to_heikin (80.0, 80.0, 90.0, 70.0, 80.0) = (400.0, 80.0)
let test1 = goukei_to_heikin (70.0, 60.0, 60.0, 40.0, 100.0) = (330.0, 66.0)

