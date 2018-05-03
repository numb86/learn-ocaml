type eki_t = {
  namae: string;
  saitan_kyori: float;
  temae_list: string list;
}

let eki_list = [
  {namae = "表参道"; saitan_kyori = infinity; temae_list = []};
  {namae = "乃木坂"; saitan_kyori = infinity; temae_list = []};
  {namae = "赤坂"; saitan_kyori = infinity; temae_list = []}
]

(* 目的：受け取った駅名を始点として扱い初期化を行う *)
(* shokika: eki_t list -> string -> eki_t list *)
let rec shokika lst shiten = match lst with
  [] -> []
  | ({namae = n} as first) :: rest ->
    if n = shiten
      then {namae = shiten; saitan_kyori = 0.; temae_list = [shiten]} :: rest
      else first :: (shokika rest shiten)

let test1 = shokika eki_list "表参道" = [
  {namae = "表参道"; saitan_kyori = 0.; temae_list = ["表参道"]};
  {namae = "乃木坂"; saitan_kyori = infinity; temae_list = []};
  {namae = "赤坂"; saitan_kyori = infinity; temae_list = []}
]
let test2 = shokika eki_list "赤坂" = [
  {namae = "表参道"; saitan_kyori = infinity; temae_list = []};
  {namae = "乃木坂"; saitan_kyori = infinity; temae_list = []};
  {namae = "赤坂"; saitan_kyori = 0.; temae_list = ["赤坂"]}
]
