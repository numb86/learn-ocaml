(* 目的： yaoya_list を元にitem の値段を調べる *)
(* price: string -> (string * int) list -> int option *)
let rec price item yaoya_list = match yaoya_list with
  [] -> None
  | (yasai, nedan) :: rest -> if yasai = item then Some (nedan) else price item rest
