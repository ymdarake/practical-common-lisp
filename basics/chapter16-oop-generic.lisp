;; (defgeneric withdraw (account amount)
;;   (:documentation "withdraw 'amount' from 'account'. If the current balance is lower than the amount, then notify error."))

;; (defmethod withdraw ((account bank-account) amount)
;;   (when (< (balance account) amount)
;;     (error "Account overdrawn."))
;;   (decf (balance account) amount))

;; (defmethod withdraw ((account checking-account) amount)
;;   (let ((overdraft (- amount (balance account))))
;;     (when (plusp overdraft)
;;       (withdraw (overdraft-account account) overdraft)
;;       (incf (balance account) overdraft)))
;;   (call-next-method))

;; (defmethod withdraw ((proxy proxy-account) amount)
;;   (withdraw (proxied-account proxy) amount))


;; ;; before, after, around

;; (defmethod withdraw :before ((account checking-account) amount)
;;   (let ((overdraft (- amount (balance account))))
;;     (when (plusp overdraft)
;;       (withdraw (overdraft-account account) overdraft)
;;       (incf (balance account) overdraft))))

(defvar *account-numbers* 0)

(defclass bank-account ()
  ((customer-name
    :initarg :customer-name
    :initform (error "Must supply a customer name."))
   (balance
    :initarg :balance
    :initform 0)
   (account-number
    :initform (incf *account-numbers*))))

; (defparameter *account* (make-instance 'bank-account))

;; (setf (slot-value *account* 'customer-name) "John Doe")
;; (setf (slot-value *account* 'balance) 1000)
;; (slot-value *account* 'customer-name)
;; (slot-value *account* 'balance)

