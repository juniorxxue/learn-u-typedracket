#lang typed/racket

;; curry
(: mult-three : Integer -> Integer -> Integer -> Integer)
(define (((mult-three x) y) z)
  (* x y z))

(define mult-two-with-nine (mult-three 9))
((mult-two-with-nine 2) 3)

(define mult-with-eighteen (mult-two-with-nine 2))
(mult-with-eighteen 10)

;; another curry demo

;; careful to use `cond`, it has to be complete
(: compare : Integer Integer -> Symbol)
(define (compare x y)
  (cond
    [(> x y) 'greater]
    [(< x y) 'smaller]
    [else 'equal]))

(define compare-with-hundred (curry compare 100))
(compare-with-hundred 99)

(: apply-twice : (All (a) (a -> a) a -> a))
(define (apply-twice f x)
  (f (f x)))

(apply-twice add1 10)

(: zip-with : (All (a b c) (a b -> c) (Listof a) (Listof b) -> (Listof c)))
(define/match (zip-with f lx ly)
  [(_ '() _) '()]
  [(_ _ '()) '()]
  [(f (cons x xs) (cons y ys)) (cons (f x y) (zip-with f xs ys))])

(zip-with + '(4 2 5 6) '(2 6 2 3))

(map add1 '(1 5 1 3 1 6))
(filter (lambda ([x : Integer]) (= x 3)) '(1 2 3 4 5 5))

;; fold