type eki_t = {
  namae: string;
  saitan_kyori: float;
  temae_list: string list;
}

type ekimei_t = { 
  kanji   : string; (* 駅名 *) 
  kana    : string; (* 読み *) 
  romaji  : string; (* ローマ字 *) 
  shozoku : string; (* 所属線名 *) 
} 

(* 目的：ekimei_t list を受け取り、指定された駅を始点として初期化した eki_t list を返す *)
(* make_initial_eki_list: ekimei_t list -> string -> eki_t list *)
let make_initial_eki_list lst shiten =
  List.map
    (fun {kanji = k} ->
      if k = shiten
        then {namae = shiten; saitan_kyori = 0.; temae_list = [shiten]}
        else {namae = k; saitan_kyori = infinity; temae_list = []})
    lst

let ekimei1 = {kanji="表参道"; kana="おもてさんどう"; romaji="omotesandou"; shozoku="千代田線"}
let ekimei2 = {kanji="乃木坂"; kana="のぎざか"; romaji="nogizaka"; shozoku="千代田線"}
let ekimei3 = {kanji="赤坂"; kana="あかさか"; romaji="akasaka"; shozoku="千代田線"}

let ekimei_list1 = [ekimei1; ekimei2]
let ekimei_list2 = [ekimei1; ekimei2; ekimei3]

let test1 = make_initial_eki_list ekimei_list1 "表参道" = [
  {namae = "表参道"; saitan_kyori = 0.; temae_list = ["表参道"]};
  {namae = "乃木坂"; saitan_kyori = infinity; temae_list = []}
]
let test2 = make_initial_eki_list ekimei_list2 "赤坂" = [
  {namae = "表参道"; saitan_kyori = infinity; temae_list = []};
  {namae = "乃木坂"; saitan_kyori = infinity; temae_list = []};
  {namae = "赤坂"; saitan_kyori = 0.; temae_list = ["赤坂"]}
]
