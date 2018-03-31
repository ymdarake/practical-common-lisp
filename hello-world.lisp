; C-x C-e evaluate at the ending parenthesis.
; C-x o next buffer.
; C-c C-c compile.
; C-c C-z REPL.
; , on REPL and type quit to close slime buffers. M-x slime to start SLIME.
; invoke error on REPL to dive into debugger mode. q to quit.
; (load "/path/to/file") to load file (on REPL).
; or C-c C-l on the file.

(defun hello-world () (format t "Hello, world!"))

