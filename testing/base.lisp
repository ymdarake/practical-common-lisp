(defvar *test-name* nil)

(defun test-+-ver0 ()
  (report-test (= (+ 1 2) 3) '(= (+ 1 2) 3))
  (report-test (= (+ 1 2 3) 6) '(= (+ 1 2 3) 6)))

(defmacro deftest (name parameters &body body)
  "define test function with FQN. use `check` to run each tests."
  `(defun ,name ,parameters
     (let ((*test-name* (append *test-name* (list ',name)))) ;name is just a symbol
       ,@body)))

(defmacro combine-results (&body forms)
  "combine the results of `forms` in the given order."
  (with-gensyms (result)
    `(let ((,result t))
       ,@(loop for f in forms collect `(unless ,f (setf ,result nil)))
       ,result)))

(defmacro check (&body forms)
  "execute each `form` and pass it to reporter."
  `(combine-results
     ,@(loop for f in forms collect `(report-test ,f ',f))))

(defun report-test (result form)
  "report a result of single case. called by `check`."
  (format t "~:[FAIL~;pass~] ... ~a: ~a~%" result *test-name* form)
  result)

(deftest test-+ ()
  (check
    (= (+ 1 2) 3)
    (= (+ 1 2 3) 6)
    (= (+ -1 -3) 4)))

(deftest test-* ()
  (check
    (= (* 1 2) 2)
    (= (* 3 5) 15)
    (= (* -2 9) -18)))

(deftest test-arithmetic ()
  (combine-results
    (test-+)
    (test-*)))

;;;

(defmacro with-gensyms ((&rest names) &body body)
  `(let ,(loop for n in names collect `(,n (gensym)))
     ,@body))
