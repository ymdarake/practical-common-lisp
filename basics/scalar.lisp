;;; number

; (+ 1 2 3)
; (+ 10.0 3.0)
; (+ 1 2.0) ; 3.0
; (+ #c(1 2) 3) ; #c(4 2)

; = /= > >= < <=


;;; char

; #\x represent the char x
; #\Space #\Newline

; case sensitive
; CHAR= CHAR/= CHAR< CHAR<= CHAR> CHAR>=

; case insensitive
; CHAR-EQUAL CHAR-NOT-EQUAL CHAR-LESSP CHAR-GREATERP CHAR-NOT-GREATERP CHAR-NOT-LESSP


;;; string

; "hogehoge" represent the string hogehoge
; double quote mark and back slash mark require to be escaped by back slash:
; - "hoge\"hoge" "hoge\\hoge"

; STRING= STRING/= STRING< STRING> STRING <= STRING>=
; STRING-EQUAL and so on...
; only takes 2 strings:
; - (string= "foobarbaz" "quuxbarfoo" :start1 3 :end1 6 :start2 4 :end2 7)

