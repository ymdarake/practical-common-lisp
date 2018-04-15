
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

