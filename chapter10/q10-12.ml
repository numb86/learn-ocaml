#use "q10-10.ml" 
#use "q10-11.ml" 

(* 目的：ローマ字の駅名をふたつ受け取り、その距離を整形した文字列で返す *)
(* kyori_wo_hyoji: string -> string -> string *)
let kyori_wo_hyoji eki1 eki2 =
  let eki_kanji1 = romaji_to_kanji eki1 global_ekimei_list in
  let eki_kanji2 = romaji_to_kanji eki2 global_ekimei_list in
  if eki_kanji1 = "" then eki1 ^ "という駅は存在しません"
  else if eki_kanji2 = "" then eki2 ^ "という駅は存在しません"
  else let ekikan = get_ekikan_kyori eki_kanji1 eki_kanji2 global_ekikan_list in
    if ekikan = infinity then eki_kanji1 ^ "駅と" ^ eki_kanji2 ^ "駅はつながっていません"
    else eki_kanji1 ^ "駅から" ^ eki_kanji2 ^ "駅までは" ^ string_of_float ekikan ^ "kmです"

let test1 = kyori_wo_hyoji "hoge" "omotesandou"
  = "hogeという駅は存在しません"
let test2 = kyori_wo_hyoji "tokyo" "omotesandou"
  = "東京駅と表参道駅はつながっていません"
let test3 = kyori_wo_hyoji "shibuya" "omotesandou"
  = "渋谷駅から表参道駅までは1.3kmです"
let test4 = kyori_wo_hyoji "omotesandou" "gaienmae"
  = "表参道駅から外苑前駅までは0.7kmです"
