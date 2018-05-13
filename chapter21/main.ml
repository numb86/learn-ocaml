(* メイン関数 *)
(* main: int -> unit *)
let main n = let kekka = Fac.f n in
  (
    print_int n;
    print_string " の階乗は ";
    print_int kekka;
    print_string " です。";
    print_newline ();
  )

let _ = main (int_of_string Sys.argv.(1))
