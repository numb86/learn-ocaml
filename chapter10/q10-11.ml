(* 目的：漢字の駅名をふたつと ekikan_t list を受け取り、駅間の距離を返す *)
(* get_ekikan_kyori: string -> string -> ekikan_t list -> float *)
let rec get_ekikan_kyori eki1 eki2 lst = match lst with
  [] -> infinity
  | {kiten = ki; shuten = sh; kyori = ky} :: rest ->
    if (ki = eki1 && sh = eki2) || (ki = eki2 && sh = eki1)
      then ky
      else get_ekikan_kyori eki1 eki2 rest

let test1 = get_ekikan_kyori "東京" "表参道" global_ekikan_list = infinity
let test2 = get_ekikan_kyori "渋谷" "表参道" global_ekikan_list = 1.3
let test3 = get_ekikan_kyori "表参道" "外苑前" global_ekikan_list = 0.7
