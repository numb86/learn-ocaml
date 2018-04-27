(* 目的：ローマ字の駅名と ekimei_t list を受け取ると、その駅の漢字表記を返す *)
(* romaji_to_kanji: string -> ekimei_t list -> string *)
let rec romaji_to_kanji ekimei_romaji lst = match lst with
  [] -> ""
  | {romaji = r; kanji = k} :: rest ->
    if r = ekimei_romaji
      then k
      else romaji_to_kanji ekimei_romaji rest

let test1 = romaji_to_kanji "hoge" global_ekimei_list = ""
let test2 = romaji_to_kanji "yoyogiuehara" global_ekimei_list = "代々木上原"
let test3 = romaji_to_kanji "yushima" global_ekimei_list = "湯島"
