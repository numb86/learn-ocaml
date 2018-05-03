#use "chapter8/q8-3.ml"  ;;
 
(* 目的： person_t を受け取り、その名前を返す無名関数 *)
fun person -> match person with {name = n} -> n
