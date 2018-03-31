(* 学生ひとり分のデータ（名前、点数、成績）を表す型 *)
type gakusei_t = {
  namae: string;
  tensuu: int;
  seiseki: string;
}

(* 目的：学生のデータ gakusei を受け取り、成績を付与して返す *)
(* hyouka = gakusei_t -> gakusei_t *)
let hyouka gakusei = match gakusei with
  {namae = n; tensuu = t; seiseki = s} ->
    if t >= 80 then {namae = n; tensuu = t; seiseki = "A"}
    else if t >= 70 then {namae = n; tensuu = t; seiseki = "B"}
    else if t >= 60 then {namae = n; tensuu = t; seiseki = "C"}
    else {namae = n; tensuu = t; seiseki = "D"}

(* テスト *)
let test1 = hyouka {namae="tanaka"; tensuu=80; seiseki=""}
  = {namae="tanaka"; tensuu=80; seiseki="A"}
let test2 = hyouka {namae="tanaka"; tensuu=70; seiseki=""}
  = {namae="tanaka"; tensuu=70; seiseki="B"}
let test3 = hyouka {namae="tanaka"; tensuu=61; seiseki=""}
  = {namae="tanaka"; tensuu=61; seiseki="C"}
let test4 = hyouka {namae="tanaka"; tensuu=60; seiseki=""}
  = {namae="tanaka"; tensuu=60; seiseki="C"}
let test5 = hyouka {namae="tanaka"; tensuu=59; seiseki=""}
  = {namae="tanaka"; tensuu=59; seiseki="D"}
let test6 = hyouka {namae="tanaka"; tensuu=50; seiseki=""}
  = {namae="tanaka"; tensuu=50; seiseki="D"}

