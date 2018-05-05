(* 八百屋においてある野菜と値段のリスト *)
let yaoya_list = [
  ("トマト", 300);
  ("たまねぎ", 200);
  ("にんじん", 150);
  ("ほうれん草", 200)
]

(* 目的： yaoya_list を元にitem の値段を調べる *)
(* price: string -> (string * int) list -> int option *)
let rec price item yaoya_list = match yaoya_list with
  [] -> None
  | (yasai, nedan) :: rest -> if yasai = item then Some (nedan) else price item rest

(* 目的：野菜のリストと八百屋のリストを受け取り、八百屋に置いていない野菜の数を返す *)
(* count_urikire_yasai: string list -> (string * int) list -> int *)
let rec count_urikire_yasai yasai_list yaoya_list = match yasai_list with
  [] -> 0
  | first :: rest ->
    match price first yaoya_list with
      None -> 1 + count_urikire_yasai rest yaoya_list
      | Some (p) -> count_urikire_yasai rest yaoya_list

let test1 = count_urikire_yasai [] yaoya_list = 0
let test2 = count_urikire_yasai ["たまねぎ"] yaoya_list = 0
let test3 = count_urikire_yasai ["じゃがいも"] yaoya_list = 1
let test3 = count_urikire_yasai ["きゅうり"; "たまねぎ"; "じゃがいも"] yaoya_list = 2
