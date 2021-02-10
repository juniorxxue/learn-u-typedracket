#lang typed/racket

; Pattern Matching

(: lucky (-> Integer String))
(define (lucky x)
  (match x
    [7 "Lucky Number Seven"]
    [_ "Sorry, you're out of luck, pal"])
  )

(: sayme (-> Integer String))
(define (sayme x)
  (match x
    [1 "One"]
    [2 "Two"]
    [3 "Three"]
    [4 "Four"]
    [_ "Not between 1 and 4"]))


;; it would always say "not ... 1 and 4"
(define (sayme-wrongly x)
  (match x
    [_ "Not between 1 and 4"]
    [1 "One"]
    [2 "Two"]
    [3 "Three"]
    [4 "Four"]
    ))

(: factorial (-> Integer Integer))
(define (factorial x)
  (match x
    [0 1]
    [n (* n (factorial (- n 1)))]))

;; pattern match on pairs
(: add-vectors (-> (Pairof Number Number) (Pairof Number Number) (Pairof Number Number)))
(define (add-vectors x y)
  (match x
    [(cons x1 x2) (match y
                    [(cons y1 y2) (cons (+ x1 y1) (+ x2 y2))])]))

;; more elegant way
(: add-pairs (-> (Pairof Number Number) (Pairof Number Number) (Pairof Number Number)))
(define/match (add-pairs x y)
  [((cons x1 x2) (cons y1 y2)) (cons (+ x1 y1) (+ x2 y2))])

;; (add-vectors '(1 . 1) '(1 . 2))
;; (add-pairs '(1 . 1) '(1 . 2))
