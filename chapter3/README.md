# 第3章　変数の定義

同じ情報を複数の場所に書いていたら、プログラムの構成を見直して、それを避ける。  
その方法の一つが、変数の利用。

変数の定義方法。  
変数名の先頭の文字は、アルファベットの小文字でないといけない。

```
let 変数名 = 式
```

```ocaml
# let pi = 3.14 ;;
val pi : float = 3.14
# pi ;;
- : float = 3.14
# pi *. 2.0 ;;
- : float = 6.28
```

関数型言語における変数は、基本的に書き変えることが出来ない。  
それにより、プログラムの見通しがよくなり、間違いが減り、プログラムの信頼性が高まる。