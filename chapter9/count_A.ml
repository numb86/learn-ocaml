(* 学生ひとり分のデータ（名前、点数、成績）を表す型 *)
type gakusei_t = {
  namae: string;
  tensuu: int;
  seiseki: string;
}

(* gakusei_t list 型のデータの例 *)
let lst1 = []
let lst2 = [{namae = "山田"; tensuu = 70; seiseki = "B"}]
let lst3 = [
  {namae = "山田"; tensuu = 70; seiseki = "B"};
  {namae = "鈴木"; tensuu = 80; seiseki = "A"}
]
let lst4 = [
  {namae = "鈴木"; tensuu = 80; seiseki = "A"};
  {namae = "山田"; tensuu = 70; seiseki = "B"};
  {namae = "高橋"; tensuu = 85; seiseki = "A"}
]

(* 目的：学生リスト lst に含まれている成績Aの人数を返す *)
(* count_A: gakusei_t list -> int *)
let rec count_A lst = match lst with
  [] -> 0
  | {namae = n; tensuu = t; seiseki = s} :: rest
    -> if s = "A" then 1 + count_A rest else count_A rest

let test1 = count_A lst1 = 0
let test2 = count_A lst2 = 0
let test3 = count_A lst3 = 1
let test4 = count_A lst4 = 2
