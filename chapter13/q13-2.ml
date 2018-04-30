(* 人に関する情報を格納するレコード *)
type person_t = {
  name : string; (* 名前 *)
  shincho : float; (* 身長 *)
  taiju : float; (* 体重 *)
  tsuki : int; (* 誕生月 *)
  hi : int; (* 誕生日 *) 
  ketsueki : string;	(* 血液型 *)
}

let person1 = {
  name = "浅井";
  shincho = 1.72;
  taiju = 58.5;
  tsuki = 9;
  hi = 17;
  ketsueki = "A"
}

let person2 = {
  name = "宮原";
  shincho = 1.63;
  taiju = 55.0;
  tsuki = 6;
  hi = 30;
  ketsueki = "B"
}

let person3 = {
  name = "中村";
  shincho = 1.68;
  taiju = 63.0;
  tsuki = 6;
  hi = 6;
  ketsueki = "O"
}

let lst1 = [person1]
let lst2 = [person2; person3]

(* 目的：person_t を受け取り、その人の名前を返す *)
(* get_namae: person_t -> string *)
let get_namae person = match person with {name = n} -> n

let test1 = get_namae person1 = "浅井"

(* 目的：person_t list を受け取り、そこに含まれる人の名前のリストを返す *)
(* person_namae: person_t list -> string list *)
let person_namae lst = List.map get_namae lst

let test2 = person_namae [] = []
let test3 = person_namae lst1 = ["浅井"]
let test4 = person_namae lst2 = ["宮原"; "中村"]
