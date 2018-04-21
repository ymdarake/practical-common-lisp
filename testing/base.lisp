(defvar *test-name* nil)

(defun test-+-ver0 ()
  (report-test (= (+ 1 2) 3) '(= (+ 1 2) 3))
  (report-test (= (+ 1 2 3) 6) '(= (+ 1 2 3) 6)))

(defun report-test (result form)
  (format t "~:[FAIL~;pass~] ... ~a: ~a~%" result *test-name* form)
  result)

(defmacro deftest (name parameters &body body)
  `(defun ,name ,parameters
     (let ((*test-name* ',name));name is just a symbol
       ,@body)))

(deftest test-+ ()
  (check
    (= (+ 1 2) 3)
    (= (+ 1 2 3) 6)
    (= (+ -1 -3) 4)))

(defmacro combine-results (&body forms)
  (with-gensyms (result)
    `(let ((,result t))
       ,@(loop for f in forms collect `(unless ,f (setf ,result nil)))
       ,result)))

(defmacro check (&body forms)
  `(combine-results
     ,@(loop for f in forms collect `(report-test ,f ',f))))

;;;

(defmacro with-gensyms ((&rest names) &body body)
  `(let ,(loop for n in names collect `(,n (gensym)))
     ,@body))
