#use "metro.ml"
#use "chapter13/q13-6.ml"

(* 駅の例 *) 
let eki1 = {namae="池袋"; saitan_kyori = infinity; temae_list = []} 
let eki2 = {namae="新大塚"; saitan_kyori = 1.2; temae_list = ["新大塚"; "茗荷谷"]} 
let eki3 = {namae="茗荷谷"; saitan_kyori = 0.; temae_list = ["茗荷谷"]} 
let eki4 = {namae="後楽園"; saitan_kyori = infinity; temae_list = []} 
 
(* 駅リストの例 *) 
let lst = [eki1; eki2; eki3; eki4] 

(* 目的：直前に確定した駅 p と、未確定の駅のリスト v を受け取り、 *)
(* 必要な更新処理を行った後の未確定の駅のリストを返す *)
(* koushin: eki_t -> eki_t list -> eki_t list *)
let koushin p v = let f q = koushin1 p q in List.map f v

let test1 = koushin eki2 [] = [] 
let test2 = koushin eki2 lst = 
 [{namae="池袋"; saitan_kyori = 3.0; temae_list = ["池袋"; "新大塚"; "茗荷谷"]}; 
  eki2; eki3; eki4] 
