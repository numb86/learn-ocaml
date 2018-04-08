(* 駅名の情報を格納するレコード型 *)
type ekimei_t = {
  kanji: string; (* 漢字の駅名 *)
  kana: string; (* 平仮名の駅名 *)
  romaji: string; (* ローマ字の駅名 *)
  shozoku: string; (* 所属する路線名 *)
}
