;;; input stream
;; OPEN, READ-CHAR, READ-LINE, CLOSE
(let ((in (open "/some/file/name.txt" :if-does-not-exist nil)))
  (when in
    (format t "~a~%" (read-line in))
    (close in)))

(let ((in (open "/some/file/name.txt" :if-does-not-exist nil)))
  (when in
    (loop for line = (read-line in nil)
          while line do (format t "~a~%" line))
    (close in)))

;; READ reads an s-expression and return an lisp object
(defparameter *s* (open "/some/file/name.txt" :if-does-not-exist nil))
(read *s*)


;;; output stream
;; OPEN with `:direction :output`
(open "/some/file/name.txt" :direction :output :if-exists :supersede)

;; WRITE-CHAR, WRITE-STRING, WRITE-LINE, TERPRI, FRESH-LINE

;;; always CLOSE FILE
;; WITH-OPEN-FILE
(with-open-file (stream "/some/file/name.txt")
  (format t "~a~%" (read-line stream)))

(with-open-file (stream "/some/file/output.txt" :direction :output)
  (format stream "Some text."))

;;; PATHNAME, #"path", PATHNAME-DIRECTORY, PATHNAME-NAME, PATHNAME-TYPE, ...
(pathname-directory (pathname "/foo/bar/baz.txt")); (:ABSOLUTE "foo" "bar")
(pathname-name (pathname "/foo/bar/baz.txt")); "baz"
(pathname-type (pathname "/foo/bar/baz.txt")); "txt"
;; NAMESTRING, DIRECTORY-NAMESTRING, FILE-NAMESTRING
(namestring #p"/foo/bar/baz.txt"); "/foo/bar/baz.txt"
(directory-namestring #p"/foo/bar/baz.txt"); "/foo/bar/"
(file-namestring #p"/foo/bar/baz.txt"); "baz.txt"




