(* 目的：連想リスト lst の中から、キーが data の値を返す *) 
(* キーが見つからなかったときは、 *)
(* assoc : 'a -> ('a * 'b) list -> 'b *) 
let rec assoc data lst = match lst with
  [] -> raise Not_found
  | (key, value) :: rest -> if key = data then value else assoc data rest
 
(* テスト *) 
let test1 = assoc "後楽園" [("新大塚", 1.2); ("後楽園", 1.8)] = 1.8 
