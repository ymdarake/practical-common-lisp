;;; optional parameter (positional)

;; c and d are optional. c is 99 by default.
(defun foo (a b &optional (c 99) d) (list a b c d))

;; we can refer to other parameters for default values
(defun make-rectangle (width &optional (height width)) (list width height))

;; we can check if optional arguments are specified or not
(defun bar (a b &optional (c 3 c-supplied-p))
  (list a b c c-supplied-p))


;;; reset parameter
;(defun demo-plus (&rest numbers) ...)


;;; keyword parameter

(defun demo-keyword (&key a b c) (list a b c))
; (foo) -> (NIL NIL NIL)
; (foo :a 1) -> (1 NIL NIL)
; (foo :c 1) -> (NIL NIL 1)

;; we can use default value and supplied-p
(defun demo-keyword-sup (&key (a 0) (b 0 b-supplied-p) (c (+ a b))))


;;; combinations

(defun rest-and-keyword (&rest rest &key a b c) (list rest a b c)); (foo :a 1 :b 2 :c 3) -> ((:A 1 :B 2 :C 3) 1 2 3)






