#lang racket

;; --------------------------
;; Basics
;; --------------------------

(define-syntax foo
  (lambda (stx)
    (syntax "I am foo")))

;; shorthand
(define-syntax (also-foo stx)
  (syntax "I am also foo"))

(define-syntax (quoted-foo stx)
  #'"I am also foo, using #' instead of syntax")

(define-syntax (say-hi stx)
  #'(displayln "hi"))

(define-syntax (show-me stx)
  (print stx)
  #'(void))

(define stx #'(if x (list "true") #f))

(define-syntax (reverse-me stx)
  (datum->syntax stx (reverse (cdr (syntax->datum stx)))))

(define-syntax (another-foo stx)
  (make-pipe)
  #'(void))

(require (for-syntax racket/match))
;; only racket/base can be used
(define-syntax (our-if-using-match stx)
  (match (syntax->list stx)
    [(list name condition true-expr false-expr)
     (datum->syntax stx `(cond [,condition ,true-expr]
                               [else ,false-expr]))]))


;; define-for-syntax
;; which composes begin-for-syntax and define

;; --------------------------
;; More Useful
;; --------------------------

;; we don't need match
;; quasi-quoting and unquoting
;; we use a "template" here to directly use variables from the pattern

(define-syntax (our-if-using-syntax-case stx)
  (syntax-case stx ()
    [(_ condition true-expr false-expr)
     #'(cond [condition true-expr]
             [else false-expr])]))

;; a shorthand for simpler one

(define-syntax-rule (our-if-using-syntax-rule condition true-expr false-expr)
  (cond [condition true-expr]
        [else false-expr]))