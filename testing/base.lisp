(defun test+- ()
  (report-test (= (+ 1 2) 3) '(= (+ 1 2) 3))
  (report-test (= (+ 1 2 3) 6) '(= (+ 1 2 3) 6)))

(defun report-test (result form)
  (format t "~:[FAIL~;pass~] ... ~a~%" result form))

(defmacro check (&body forms)
  `(progn
     ,@(loop for f in forms collect `(report-test ,f ',f))))

(defun test-+ ()
  (check
    (= (+ 1 2) 3)
    (= (+ 1 2 3) 6)))

