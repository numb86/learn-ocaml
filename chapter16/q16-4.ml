#use "metro.ml"

type eki_t = {
  namae: string;
  saitan_kyori: float;
  temae_list: string list;
}

(* 目的：eki_t list を受け取り、「最短距離最小の駅」と「それ以外の駅のリスト」の組を返す *)
(* saitan_wo_bunri: eki_t list -> eki_t * eki_t list *)
let saitan_wo_bunri eki_list = match eki_list with 
    [] -> ({namae = ""; saitan_kyori = infinity; temae_list = []}, []) 
  | first :: rest -> 
      List.fold_right (fun first (p, v) -> 
			 match (first, p) with 
			   ({namae = fn; saitan_kyori = fs; temae_list = ft}, 
			    {namae = sn; saitan_kyori = ss; temae_list = st}) -> 
			     if fs < ss then (first, p :: v) 
			     else (p, first :: v)) 
		      rest 
		      (first, []) 

(* 目的：漢字の駅名をふたつと ekikan_t list を受け取り、駅間の距離を返す *)
(* get_ekikan_kyori: string -> string -> ekikan_t list -> float *)
let rec get_ekikan_kyori eki1 eki2 lst = match lst with
  [] -> infinity
  | {kiten = ki; shuten = sh; kyori = ky} :: rest ->
    if (ki = eki1 && sh = eki2) || (ki = eki2 && sh = eki1)
      then ky
      else get_ekikan_kyori eki1 eki2 rest

(* 目的：未確定の駅のリスト v を必要に応じて更新したリストを返す *) 
(* koushin : eki_t -> eki_t list -> ekikan_t list -> eki_t list *) 
let koushin p v ekikan_list = match p with 
  {namae = pn; saitan_kyori = ps; temae_list = pt} -> 
    List.map (fun q -> match q with 
	       {namae = qn; saitan_kyori = qs; temae_list = qt} -> 
		 let kyori = get_ekikan_kyori pn qn ekikan_list in 
		 if kyori = infinity 
		 then q 
		 else if ps +. kyori < qs 
		 then {namae = qn; saitan_kyori = ps +. kyori; 
				   temae_list = qn :: pt} 
		 else q) 
	     v 
 
(* 目的：未確定駅のリストと駅間リストから、各駅への最短路を求める *) 
(* dijkstra_main : eki_t list -> ekikan_t list -> eki_t list *) 
let rec dijkstra_main eki_list ekikan_list = match eki_list with 
    [] -> [] 
  | first :: rest -> 
      let (saitan, nokori) = saitan_wo_bunri (first :: rest) in 
      let eki_list2 = koushin saitan nokori ekikan_list in 
      saitan :: dijkstra_main eki_list2 ekikan_list 
 
(* eki_list2 は eki_list より長さが必ずひとつ短いので、停止する *) 
 
(* 駅の例 *) 
let eki1 = {namae="池袋"; saitan_kyori = infinity; temae_list = []} 
let eki2 = {namae="新大塚"; saitan_kyori = 1.2; temae_list = ["新大塚"; "茗荷谷"]} 
let eki3 = {namae="茗荷谷"; saitan_kyori = 0.; temae_list = ["茗荷谷"]} 
let eki4 = {namae="後楽園"; saitan_kyori = infinity; temae_list = []} 
 
(* 駅リストの例 *) 
let lst = [eki1; eki2; eki3; eki4] 
 
(* テスト *) 
let test1 = dijkstra_main [] global_ekikan_list = [] 
let test2 = dijkstra_main lst global_ekikan_list = 
  [{namae = "茗荷谷"; saitan_kyori = 0.; temae_list = ["茗荷谷"]}; 
   {namae = "新大塚"; saitan_kyori = 1.2; temae_list = ["新大塚"; "茗荷谷"]}; 
   {namae = "後楽園"; saitan_kyori = 1.8; temae_list = ["後楽園"; "茗荷谷"]}; 
   {namae = "池袋"; saitan_kyori = 3.; temae_list = ["池袋"; "新大塚"; "茗荷谷"]}] 
