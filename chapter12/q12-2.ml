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
let rec make_eki_list lst = match lst with
  [] -> []
  | {kanji = k} :: rest
    -> {namae = k; saitan_kyori = infinity; temae_list = []} :: (make_eki_list rest)

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
