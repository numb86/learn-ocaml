(* 人に関する情報を格納するレコード *)
type person_t = {
  name : string; (* 名前 *)
  shincho : float; (* 身長 *)
  taiju : float; (* 体重 *)
  tsuki : int; (* 誕生月 *)
  hi : int; (* 誕生日 *) 
  ketsueki : string;	(* 血液型 *)
}

(* 目的：person_t list を受け取り、最初のA型の人のレコードをオプション型で返す *)
(* first_A: person_t list -> person_t option *)
let rec first_A lst = match lst with
  [] -> None
  | ({ketsueki = k} as first) :: rest ->
    if k = "A" then Some (first) else first_A rest

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
  ketsueki = "A"
}

let test1 = first_A [] = None
let test1 = first_A [person1] = Some (person1)
let test1 = first_A [person3; person1] = Some (person3)
let test1 = first_A [person2] = None
