(* メイン関数 *)
(* main: unit -> unit *)
let main () = let kekka = Fac.f 10 in
  (
    print_string "10の階乗は ";
    print_int kekka;
    print_string " です。";
    print_newline ();
  )

let _ = main ()
