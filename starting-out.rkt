#lang typed/racket

;; some simple arithmetic
(+ 2 15)
(* 49 100)
(- 1892 1472)
(/ 5 2)

;; one line and no worry about precedence
(- (* 50 100) 4999)

;; boolean
(and #t #f)
(or #t #f)
(not #f)

;; eqality
(equal? 1 1)
(equal? "hello" "hello")

;; other useful functions
(add1 8)
(min 9 19)
(max 100 101)

;; Baby's first functions
(: double-me (-> Number Number))
(define double-me (lambda (x) (+ x x)))

(: double-us (-> Number Number Number))
(define double-us (lambda (x y) (+ (* 2 x) (* 2 y))))

;; type signiature is mandatory
(: double-us-2 (-> Number Number Number))
(define (double-us-2 x y) (+ (double-me x) (double-me y)))

;; opeartor > accepts Integer
;; Number is a union type, we'll see later
(: double-small-number (-> Integer Integer))
(define (double-small-number x)
  (if (> x 100) x (* x 2)))

;; let binding
(let ([x 99])
  (double-small-number x))
;; we didn't use type anno here

(define lost-numbers (list 4 8 10 16 23 42))

;; list manipulation
(append (list 1 2 3 4) (list 9 10 11 12))
(cons 5 '(1 2 3 4 5))

;; (list 1 2 3) is a syntactic suger for
(cons 1 (cons 2 (cons 3 '())))

;; !! Operator
(index-of '(0 1 2 3 4) 3)
(equal? '(1 2) '(1 2))

;; head and tail
(car '(5 4 3 2 1))
(cdr '(5 4 3 2 1))

(length '(5 4 3 2 1))
(null? '(1 2 3))
(null? '())
(reverse '(5 4 3 2 1))
(take '(5 4 3 2 1) 3)
(take '(5 4 3 2 1) 0)
(drop '(8 4 2 1 5 6) 3)

(min 8 4 2 1 5 6)
(apply min '(8 4 2 1 5 6))

(: minimum (-> (Listof Real) Real))
(define (minimum x) (apply min x))
(minimum '(8 4 2 1 5 6))

(: sum (-> (Listof Real) Real))
(define (sum x) (apply + x))
(sum '(5 2 1 6 3 2 5 7))

(: product (-> (Listof Real) Real))
(define (product x) (apply * x))
(product '(6 2 1 2))

;; elem
(member 4 '(3 4 5 6))
;; it returns '(4 5 6)

;; ranges
(range 1 20)
;; not possible for letters

(take (range 1 40 2) 10)

;; since racket adopts eager evaluation
;; there isn't normal infinite loop/lazy evaluation
(for/list : (Listof Number) ([i (in-range 10)]) (* 2 i))

(for/list : (Listof Number)
    ([i (in-range 10)]
     #:when (> i 5))
  (* 2 i))

(: boom-bangs (-> (Listof Integer) (Listof String)))
(define (boom-bangs lst)
  (map (lambda ([x : Integer])
         (if (> x 10)
             "Boom"
             "Bangs"))
       lst))

(boom-bangs (range 7 13))

;; we deal with Numberic subtyping later
(car (cons 8 11))
(car (cons "WOW" #f))
