(* 学生ひとり分のデータ（名前、点数、成績）を表す型 *)
type gakusei_t = {
  namae: string;
  tensuu: int;
  seiseki: string;
}

(* gakusei_t 型のデータの例 *)
let gakusei1 = {namae = "鈴木"; tensuu = 80; seiseki = "A"}
let gakusei2 = {namae = "山田"; tensuu = 70; seiseki = "B"}
let gakusei3 = {namae = "高橋"; tensuu = 85; seiseki = "A"}

(* gakusei_t list 型のデータの例 *)
let lst1 = [gakusei1]
let lst2 = [gakusei1; gakusei2]
let lst3 = [gakusei3; gakusei1]

(* 目的：学生リスト lst の中から、最高得点の学生のレコードを返す *)
(* gakusei_max: gakusei_t list -> gakusei_t *)
let rec gakusei_max lst = match lst with
  [] -> {namae = ""; tensuu = min_int; seiseki = ""}
  | ({namae = n; tensuu = t; seiseki = s} as gakusei) :: rest
    -> match gakusei_max rest with
    {namae = n_max; tensuu = t_max; seiseki = s_max} -> if t_max > t
      then gakusei_max rest
      else gakusei

let test1 = gakusei_max lst1 = gakusei1
let test2 = gakusei_max lst2 = gakusei1
let test3 = gakusei_max lst3 = gakusei3
