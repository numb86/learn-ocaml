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

let lst1 = [person1; person2; person2; person3]

(* 目的：person_t list と血液型を受け取り、その血液型の人が何人いるかを返す *)
(* count_ketsueki: person_t list -> string -> int *)
let rec count_ketsueki lst ketsueki0 = match lst with
  [] -> 0
  | {ketsueki = k} :: rest ->
    if k = ketsueki0
      then 1 + count_ketsueki rest ketsueki0
      else count_ketsueki rest ketsueki0

let test1 = count_ketsueki [] "A" = 0
let test2 = count_ketsueki lst1 "A" = 1
let test3 = count_ketsueki lst1 "B" = 2
let test4 = count_ketsueki lst1 "O" = 1
let test5 = count_ketsueki lst1 "AB" = 0
