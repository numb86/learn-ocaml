# 第13章　一般化と高階関数

## 13.1　データの一般化

一般化は、同じようなプログラムの共通部分をくくりだすことから始まる。

ほとんど同じだけれども一部だけが異なる関数が複数ある場合は、その一部を引数として受け取るようにすることで、一般化できる。

## 13.2　関数の一般化とmap

`sqrt`は、受け取った実数の平方根を返す関数。

```ocaml
# sqrt 4. ;;
- : float = 2.
# sqrt 9. ;;
- : float = 3.
```

関数型言語での関数は、他の関数の引数や返り値として使える。  
つまり、関数を引数として受け取る関数（**高階関数**）や、関数を返す関数を作れる。  
このことを**第一級関数である**という。

高階関数の一つとして、`List.map`がある。

```ocaml
# List.map sqrt [4.; 9.; 16.] ;;
- : float list = [2.; 3.; 4.]
```

```ocaml
(* 目的：person_t を受け取り、その人の名前を返す *)
(* get_namae: person_t -> string *)
let get_namae person = match person with {name = n} -> n

(* 目的：person_t list を受け取り、そこに含まれる人の名前のリストを返す *)
(* person_namae: person_t list -> string list *)
let person_namae lst = List.map get_namae lst
```
