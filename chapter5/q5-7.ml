(* 目的：身長 m と体重 k を与えられたら、BMI指数を返す *)
(* float -> floalt -> float *)
let bmi m k = k /. (m *. m)

(* 目的：身長 m と体重 k を与えられたら、BMI指数に基いて体型を返す *)
(* float -> floalt -> string *)
let taikei m k =
  if bmi m k < 18.5 then "やせ"
  else if bmi m k < 25.0 then "標準"
  else if bmi m k < 30.0 then "肥満"
  else "高度肥満"

let taikei_test1 = taikei 1.7 50.0 = "やせ"
let taikei_test2 = taikei 1.6 60.0 = "標準"
let taikei_test3 = taikei 1.7 80.0 = "肥満"
let taikei_test4 = taikei 1.7 87.0 = "高度肥満"
