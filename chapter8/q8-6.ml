(* 駅名の情報を格納するレコード型 *)
type ekimei_t = {
  kanji: string; (* 漢字の駅名 *)
  kana: string; (* 平仮名の駅名 *)
  romaji: string; (* ローマ字の駅名 *)
  shozoku: string; (* 所属する路線名 *)
}

(* 目的：駅名のデータ ekimei_t を受け取り、駅名の情報を文字列で返す *)
(* hyoji : ekimei_t -> string *)
let hyoji ekimei =
  match ekimei with {kanji = kanji; kana = kana; shozoku = rosenmei}
  -> rosenmei ^ ", " ^ kanji ^ "（" ^ kana ^ "）"

let test1 =
  hyoji {kanji="茗荷谷"; kana="みょうがだに"; romaji="myogadani"; shozoku="丸ノ内線"}
  = "丸ノ内線, 茗荷谷（みょうがだに）"
