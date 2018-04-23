;;; sequence
;; vector
;; list

(vector)
(vector 1)
(vector 1 2)

(make-array 5 :initial-element nil); -> #(NIL NIL NIL NIL NIL)

(defun vector-demo-variable-length ()
  (make-array 5 :fill-pointer 0)); `fill-pointer` is the position to be filled.

(defparameter *x* (make-array 5 :fill-pointer 0))
(vector-push 'a *x*)
(vector-push 'b *x*)
(vector-push 'c *x*)
(vector-pop *x*)

(defun make-adjustable-vector ()
  (make-array 5 :fill-pointer 0 :adjustable t))

; vector-push-extend push element to vector

; string literal such as "foo" is, like the vector literal `#()`, fixed-size.
; but we can make variable length string in the following way:
(make-array 5 :fill-pointer 0 :adjustable t :element-type 'character); `'character` is the symbol! not a variable

;; vector as sequence
(defparameter *y* (vector 1 2 3))
(length *y*)
(elt *y* 0)
(elt *y* 1)
(elt *y* 2)
; (elt *y* 3) ; error
(setf (elt *y* 0) 10); *y* -> #(10 2 3)

(count 1 #(1 2 1 2 3 1 2 3 4)); 3
(remove 1 #(1 2 1 2 3 1 2 3 4)); #(2 2 3 2 3 4)
(remove 1 '(1 2 1 2 3 1 2 3 4)); (2 2 3 2 3 4)
(substitute 10 1 #(1 2 1 2 3 1 2 3 4)); #(10 2 10 2 3 10 2 3 4)
(substitute 10 1 '(1 2 1 2 3 1 2 3 4)); (10 2 10 2 3 10 2 3 4)
(substitute #\x #\b "foobarbaz"); "fooxarxaz"
(find 1 #(1 2 1 2 3 1 2 3 4)); 1
(find 10 #(1 2 1 2 3 1 2 3 4)); NIL
(position 1 #(1 2 1 2 3 1 2 3 4));

; `:test` to specify the 2-argument function with which you test
(count "foo" #("foo" "bar" "baz") :test #'string=); 1
; `:key` to specify the 1-argument function with which you test the equality of keys
(find 'c #((a 10) (b 20) (c 30) (d 40)) :key #'first); (C 30)

