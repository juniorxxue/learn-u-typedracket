#lang typed/racket

(define-type Ord (U Integer))
(define-type Num (U Integer))

(: maximum (-> (Listof Ord) Ord))
(define/match (maximum lst)
  [('()) (error "empty list")]
  [((cons x '())) x]
  [((cons x xs)) (if (> x (maximum xs)) x (maximum xs))]
  )

(: replicate : (All (A B) (Intersection A (Intersection Ord Num)) B -> (Listof B)))
(define (replicate n x)
  (if (<= n 0)
      '()
      (cons x (replicate (- n 1) x))))

(: take : (All (A B) (Intersection A (Intersection Ord Num)) (Listof B) -> (Listof B)))
(define (take n lst)
  (if (<= n 0)
      '()
      (match lst
        ['() '()]
        [(cons x xs) (cons x (take (- n 1) xs))])))

(: reverse : (All (A) (Listof A) -> (Listof A)))
(define/match (reverse lst)
  [('()) '()]
  [((cons x xs)) (append (reverse xs) `(,x))])