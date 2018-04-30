#use "metro.ml"

type eki_t = {
  namae: string;
  saitan_kyori: float;
  temae_list: string list;
}

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

(* 駅の例 *) 
let eki1 = {namae="池袋"; saitan_kyori = infinity; temae_list = []} 
let eki2 = {namae="新大塚"; saitan_kyori = 1.2; temae_list = ["新大塚"; "茗荷谷"]} 
let eki3 = {namae="茗荷谷"; saitan_kyori = 0.; temae_list = ["茗荷谷"]} 
let eki4 = {namae="後楽園"; saitan_kyori = infinity; temae_list = []} 

(* 直前に確定した駅 p と　未確定の駅 q を受け取り、ふたつが直接つながっているか調べ、 *)
(* つながっていない場合は q をそのまま返し、 *)
(* つながっている場合は必要に応じて最短距離とリストを更新して返す *)
(* koushin1: eki_t -> eki_t -> eki_t *)
let koushin1 p q = match (p, q) with
  ({namae = pn; saitan_kyori = pk; temae_list = pl},
   {namae = qn; saitan_kyori = qk; temae_list = ql}) ->
    let kyori = get_ekikan_kyori pn qn global_ekikan_list in
    if kyori = infinity
      then q
      else if pk +. kyori < qk
      then {namae = qn; saitan_kyori = pk +. kyori; temae_list = qn :: pl}
      else q

let test5 = koushin1 eki3 eki1 = eki1 
let test6 = koushin1 eki3 eki2 = eki2 
let test7 = koushin1 eki3 eki3 = eki3 
let test8 = koushin1 eki3 eki4 = 
	{namae="後楽園"; saitan_kyori = 1.8; temae_list = ["後楽園"; "茗荷谷"]} 
let test9 = koushin1 eki2 eki1 = 
	{namae="池袋"; saitan_kyori = 3.0; temae_list = ["池袋"; "新大塚"; "茗荷谷"]} 
let test10 = koushin1 eki2 eki2 = eki2 
let test11 = koushin1 eki2 eki3 = eki3 
let test12 = koushin1 eki2 eki4 = eki4 
