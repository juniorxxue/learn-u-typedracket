#lang typed/racket

;; (:print-type "C") :: String
;; (:print-type 10) :: Positivie-Byte
;; (:print-type (equal? 4 5)) :: Boolean


;; subtyping
(: foo (-> Integer String))
(define (foo x) (if (> x 1) "great" "hi"))

(: bar Integer)
(define bar 0)

(foo bar)

(: add-three (-> Integer Integer Integer Integer))
(define (add-three x y z) (+ x y z))
(add-three 1 2 3)
((curry add-three 1) 2 3)

;; curry style
(: add-two : Integer -> Integer -> Integer)
(define ((add-two x) y) (+ x y))

;; (:print-type car)

;; A typeclass is a sort of interface that defines some behavior.

;; use Union types and its subtyping to simulate
(define-type Eq (U String Integer))

(: my-equal? : Eq Eq -> Boolean)
(define (my-equal? x y) (equal? x y))

;; type variables are constraint from type classes
