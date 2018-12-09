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
    :initform (error "Must supply a customer name.")
    :accessor customer-name
    :documentation "Name of the customer")
   (balance
    :initarg :balance
    :initform 0
    :reader balance
    :documentation "Current balance")
   (account-number
    :initform (incf *account-numbers*)
    :reader account-number
    :documentation "Account number (unique in a bank)")
   (account-type
    :reader account-type
    :documentation "Type of the account. :gold, :silver, :bronze")))

(defmethod initialize-instance :after ((account bank-account) &key)
  (let ((balance (slot-value account 'balance)))
    (setf (slot-value account 'account-type)
          (cond
            ((>= balance 100000) :gold)
            ((>= balance 50000) :silver)
            (t :bronze)))))

; (defparameter *account* (make-instance 'bank-account))

;; (setf (slot-value *account* 'customer-name) "John Doe")
;; (setf (slot-value *account* 'balance) 1000)
;; (slot-value *account* 'customer-name)
;; (slot-value *account* 'balance)

