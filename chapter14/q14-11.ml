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

let ekimei1 = {kanji="表参道"; kana="おもてさんどう"; romaji="omotesandou"; shozoku="千代田線"}
let ekimei2 = {kanji="乃木坂"; kana="のぎざか"; romaji="nogizaka"; shozoku="千代田線"}
let ekimei3 = {kanji="赤坂"; kana="あかさか"; romaji="akasaka"; shozoku="千代田線"}

let ekimei_list1 = [ekimei1]
let ekimei_list2 = [ekimei1; ekimei2]
let ekimei_list3 = [ekimei1; ekimei2; ekimei3]

(* 目的：ekimei_t list を受け取ったら、 eki_t list を返す *)
(* make_eki_list: ekimei_t list -> eki_t list *)
let make_eki_list lst =
  List.map (fun {kanji = k} -> {namae = k; saitan_kyori = infinity; temae_list = []}) lst

let test1 = make_eki_list [] = []
let test2 = make_eki_list ekimei_list1 = [
  {namae = ekimei1.kanji; saitan_kyori = infinity; temae_list = []}
]
let test3 = make_eki_list ekimei_list2 = [
  {namae = ekimei1.kanji; saitan_kyori = infinity; temae_list = []};
  {namae = ekimei2.kanji; saitan_kyori = infinity; temae_list = []}
]
let test4 = make_eki_list ekimei_list3 = [
  {namae = ekimei1.kanji; saitan_kyori = infinity; temae_list = []};
  {namae = ekimei2.kanji; saitan_kyori = infinity; temae_list = []};
  {namae = ekimei3.kanji; saitan_kyori = infinity; temae_list = []}
]

let eki_list4 = [
  {namae = "表参道"; saitan_kyori = infinity; temae_list = []};
  {namae = "乃木坂"; saitan_kyori = infinity; temae_list = []};
  {namae = "赤坂"; saitan_kyori = infinity; temae_list = []}
]

(* 目的：受け取った駅名を始点として扱い初期化を行う *)
(* shokika: eki_t list -> string -> eki_t list *)
let shokika lst shiten =
  List.map
    (fun ({namae = n} as eki) ->
      if n = shiten
        then {namae = shiten; saitan_kyori = 0.; temae_list = [shiten]}
        else eki)
    lst

let test5 = shokika eki_list4 "表参道" = [
  {namae = "表参道"; saitan_kyori = 0.; temae_list = ["表参道"]};
  {namae = "乃木坂"; saitan_kyori = infinity; temae_list = []};
  {namae = "赤坂"; saitan_kyori = infinity; temae_list = []}
]
let test6 = shokika eki_list4 "赤坂" = [
  {namae = "表参道"; saitan_kyori = infinity; temae_list = []};
  {namae = "乃木坂"; saitan_kyori = infinity; temae_list = []};
  {namae = "赤坂"; saitan_kyori = 0.; temae_list = ["赤坂"]}
]
