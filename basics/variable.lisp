
;;; basics
;; let - initial value is nil
(defun demo-let ()
  (let ((x 10)
        (y 20)
        (z 5))
    (+ x y z)))

;; let*
(defun demo-let* ()
  (let* ((x 10)
         (y (+ x 10)))
    (list x y)))

;; is equivalent to
(defun demo-nested-let ()
  (let ((x 10))
    (let ((y (+ x 10)))
      (list x y))))

;; lexical variable, closure
;; only the code within the binding form can refer to the `lexical` variable.
;; `local` variable has `lexical` scope.
(defparameter *fn*
  (let ((count 0))
    #'(lambda () (setf count (1+ count)))))


;:; dynamic variable, special variable

(defvar *count* 0); can omit value `0`
(defvar *count* 2); cannot override

(defparameter *gap-tolerance* 0.001); cannot omit value
(defparameter *gap-tolerance* 0.003); can override

;; binding works like stack
(defvar *x* 10)
(defun foo () (format t "X: ~d~%" *x*))
(defun bar ()
  (foo)
  (let ((*x* 20)) (foo))
  (foo))
; (let ((*standard-output* *some-other-stream*)) (stuff))

;; assignment: `setf` macro
(defun demo-assign (x) (setf x 10))
(defun demo-lexical-assign ()
  (let ((y 20))
    (foo y)
    (print y)))

; we can assign to multiple target:
; (setf x 1 y 2)
; setf returns the set value
; (setf x (setf y (random 10)); x and y are has the same value


