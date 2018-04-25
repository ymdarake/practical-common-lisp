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
; we can limit the effect of the function to specific range of the sequence
; using `:start` `:end` `:from-end`
(find 'a #((a 10) (b 20) (a 30) (b 40)) :key #'first); (A 10)
(find 'a #((a 10) (b 20) (a 30) (b 40)) :key #'first :from-end t); (A 30)
; we can limit the number of removed/replaced elements
; using `:count`
(remove #\a "foobarbaz" :count 1); "foobrbaz"
(remove #\a "foobarbaz" :count 1 :from-end t); "foobarbz"

; subspecies of higher-order functions above
(count-if #'evenp #(1 2 3 4 5))
(count-if #'evenp #((1 a) (2 b) (3 c) (4 d) (5 d)) :key #'first)
(count-if-not #'evenp #(1 2 3 4 5))
(position-if #'digit-char-p "abcd0001")
(remove-if-not #'(lambda (x) (char= (elt x 0) #\f)) #("foo" "bar" "baz" "foom")); filter

(remove-duplicates #(1 2 1 2 3 1 2 3 4)); #(1 2 3 4)

(concatenate 'vector #(1 2 3) '(4 5 6))
(concatenate 'list #(1 2 3) '(4 5 6))
(concatenate 'string "abc" '(#\d #\e #\f))

;; sort
; sort, stable-sort: DESTRUCTIVE!!! DO NOT USE argument sequence after applying!
(sort (vector "foo" "bar" "baz") #'string<); #("bar" "baz" "foo")

(merge 'vector #(1 3 5) #(2 4 6) #'<); #(1 2 3 4 5 6)
(merge 'list #(1 3 5) #(2 4 6) #'<); (1 2 3 4 5 6)

;; subsequence
(subseq "foobarbaz" 3); "barbaz"
(subseq "foobarbaz" 3 6); "bar"

; setf subseq (short one has priority)
(defparameter *x* (copy-seq "foobarbaz"))
(setf (subseq *x* 3 6) "xxx"); "fooxxxbaz"
(setf (subseq *x* 3 6) "abcd"); "fooabcbaz"
(setf (subseq *x* 3 6) "xx"); "fooxxcbaz"

; fill
(fill *x* #\y :start 3 :end 6); "fooyyycbaz"

;search
(position #\b "foobarbaz"); 3
(search "bar" "foobarbaz"); 3

; mismatch: find the index where matching fails
(mismatch "foobarbaz" "foom"); 3
(mismatch "same" "same"); NIL
(mismatch "abcd-tail" "wxyz-tail" :from-end t); 4, which represents the index of its common suffix.

; predicate
(every #'evenp #(1 2 3 4 5)); NIL
(some #'evenp #(1 2 3 4 5)); T
(notany #'evenp #(1 2 3 4 5)); NIL
(notevery #'evenp #(1 2 3 4 5)); T

(every #'> #(1 2 3 4) #(5 4 3 2)); NIL
(some #'> #(1 2 3 4) #(5 4 3 2)); T
(notany #'> #(1 2 3 4) #(5 4 3 2)); NIL
(notevery #'> #(1 2 3 4) #(5 4 3 2)); T


; sequence mapping
(map 'vector #'* #(1 2 3 4 5) #(10 9 8 7 6)); zipped into one sequence
(let ((a #(1 2 3))
      (b #(4 5 6))
      (c #(6 7 8)))
  (map-into a #'+ a b c))

; extract one value from one sequence
(reduce #'+ #(1 2 3 4 5 6 7 8 9 10)); fold
(reduce #'max #(1 2 3 4 5 6 7 8 9 10))


; hash table
(defparameter *h* (make-hash-table))
(gethash 'foo *h*); NIL
(setf (gethash 'foo *h*) 'quux)
(gethash 'foo *h*); QUUX

; gethash actually returns 2 values
(defun show-values (key hash-table)
  (multiple-value-bind (value present?) (gethash key hash-table)
    (if present?
        (format nil "Value ~a actually present." value)
        (format nil "Value ~a because key not found." value))))
(show-values 'foo *h*); "Value QUUX actually present."
(setf (gethash 'bar *h*) nil)
(show-values 'bar *h*); "Value NIL actually present."
(show-values 'baz *h*); "Value NIL because key not found."
;(remhash 'bar *h*); delete key
;(clrhash *h*); clear entire the hash table.

; iterate through a hash table.
(maphash #'(lambda (k v) (format t "~a => ~a~%" k v)) *h*)
; DO NOT add/remove elements while iterating over a hash table except following 2 cases:
; (RESULT UNDEFINED)
(maphash #'(lambda (k v) (when (< v 10) (remhash k *h*))) *h*)
; we can also use the loop macro.

