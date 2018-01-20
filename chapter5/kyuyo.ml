(* 時給（円） *)
let jikyu = 950

(* 優遇時給（円） *)
let yugu_jikyu = 980

(* 基本給（円） *)
let kihonkyu = 100

(* 目的：働いた時間 x に応じたアルバイト代を計算する *)
(* kyuyo : int -> int *)
let kyuyo x =
  if x < 30 then kihonkyu + x * jikyu
  else kihonkyu + x * yugu_jikyu

(* テスト *)
let test1 = kyuyo 25 = 23850
let test1 = kyuyo 28 = 26700
let test1 = kyuyo 31 = 30480
