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

let append_tensuu first rest_result = match first with
  {tensuu = t} -> t + rest_result

(* 目的： gakusei_t list を受け取り、点数の合計を返す *)
(* gakusei_sum: gakusei_t list -> int *)
let gakusei_sum lst = List.fold_right append_tensuu lst 0

let test1 = gakusei_sum lst1 = 0
let test2 = gakusei_sum lst2 = 70
let test3 = gakusei_sum lst3 = 150
let test4 = gakusei_sum lst4 = 235
