#use "chapter12/q12-1.ml"

let rec minimum lst = match lst with
  [] -> {namae = ""; saitan_kyori = infinity; temae_list = []}
  | ({saitan_kyori = first_saitan} as first) :: rest ->
    let ({saitan_kyori = rest_result_saitan} as rest_result) = minimum rest
      in if first_saitan < rest_result_saitan then first else rest_result

(* 目的：eki_t list を受け取り、「最短距離最小の駅」と「それ以外の駅のリスト」の組を返す *)
(* saitan_wo_bunri: eki_t list -> eki_t * eki_t list *)
let saitan_wo_bunri lst = let saisyou = minimum lst in
  (saisyou, (List.filter (fun item -> not (item = saisyou)) lst))

(* 駅の例 *) 
let eki1 = {namae="池袋"; saitan_kyori = infinity; temae_list = []} 
let eki2 = {namae="新大塚"; saitan_kyori = 1.2; temae_list = ["新大塚"; "茗荷谷"]} 
let eki3 = {namae="茗荷谷"; saitan_kyori = 0.; temae_list = ["茗荷谷"]} 
let eki4 = {namae="後楽園"; saitan_kyori = infinity; temae_list = []} 
 
(* 駅リストの例 *) 
let lst = [eki1; eki2; eki3; eki4] 
 
(* テスト *) 
let test1 = minimum lst = eki3
let test2 = saitan_wo_bunri lst = (eki3, [eki1; eki2; eki4]) 
