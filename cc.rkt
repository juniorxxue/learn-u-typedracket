#lang racket

(let ((my-val (call/cc
               (lambda (the-continuation)
                 (display "This will be executed\n")
                 (the-continuation 5)
                 (display "This will not be executed\n")))))
  (display my-val)
  (newline))

(let ((my-val (call/cc
               (lambda (the-continuation)
                 the-continuation))))
  (if (procedure? my-val)
      (begin
        (display "First time through\n")
        (display "my-val is a contination object\n")
        (my-val 5))
      (begin
        (display "Second time through\n")
        (display "my-val is ")
        (display my-val)
        (newline))))


;; cooperative multi-threading

(define t1-proc
  (lambda ()
    (display "Hello from 1\n")
    (thread-yield)
    (display "Hello from 1 again\n")))

(define t2-proc
  (lambda ()
    (display "Hello from 2\n")
    (thread-yield)
    (display "Hello from 2 again\n")
    (thread-yield)
    (display "Hello from 2 again again\n")))

(define t3-proc
  (lambda ()
    (display "Hello from 3\n")
    (thread-yield)
    (display "Hello from 3 again\n")))

(define thread-list '())

(define thread-yield
  (lambda ()
    (if (null? thread-list)
        #t
        (let ((cont (call/cc (lambda (c) c))))
          (if (procedure? cont)
              (let* ((next-thread (first thread-list))
                     (remaining-threads (rest thread-list))
                     (new-thread-list
                      (append remaining-threads (list cont))))
                (set! thread-list new-thread-list)
                (next-thread 'your-turn))
              #t)))))

(define thread-end
  (lambda ()
    (if (null? thread-list)
        (exit)
        (let* ((next-thread (first thread-list))
               (remaining-threads (rest thread-list)))
          (set! thread-list remaining-threads)
          (next-thread 'your-turn)))))

(define thread-new
  (lambda (thread-proc)
    (let ((cont (call/cc (lambda (c) c))))
      (if (procedure? cont)
          (begin
            (set! thread-list (append thread-list (list cont)))
            (thread-proc)
            (thread-end))
          #t))))

                
;;(thread-new t1-proc)
;;(thread-new t2-proc)
;;(thread-new t3-proc)
;;(thread-end)

(+ 4 (call/cc
      (λ (cc)
        (cc (+ 1 2)))))
;; cc is (λ (x) (+ 4 x))