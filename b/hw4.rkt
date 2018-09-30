
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

(define (sequence low high stride)
  (if (> low high)
      empty
      (cons low (sequence (+ low stride) high stride))))

(define (string-append-map xs suffix)
  (map (lambda(i)
         (string-append i suffix)) xs))

(define (list-nth-mod xs n)
  (let* ([len (length xs)]
                    [i (remainder n len)])
    (cond [(< n 0) (error "list-nth-mod: negative number")]
        [(empty? xs) (error "list-nth-mod: empty list")]
        [else (car (list-tail xs i))
         ])))

(define ones (lambda () (cons 1 ones)))
(define (stream-for-n-steps s n)
  (if (= n 1)
      (cons (car (s)) empty)
      (cons (car (s)) (stream-for-n-steps (cdr (s)) (- n 1)))))

(define funny-number-stream
  (letrec ([f (lambda(x)(if (= (remainder x 5) 0)
                            (cons  (- 0 x) (lambda()(f (+ 1 x))))
                            (cons x (lambda()(f (+ 1 x))))))])
           (lambda()(f 1))))

(define dan-then-dog
  (letrec ([f (lambda(x)(if (string=? x "dog.jpg")
                            (cons x (lambda()(f "dan.jpg")))
                            (cons x (lambda()(f "dog.jpg")))))])
    (lambda()(f "dan.jpg"))))




(define (stream-add-zero s)
  (letrec ([f (lambda(x)(cons (cons 0 (car (x))) (lambda()(f (cdr (x))))))])
    (lambda()(f s))))

(define (cycle-lists xs ys)
  (letrec ([f (lambda(x)(cons (cons (list-nth-mod xs x) (list-nth-mod ys x))
                              (lambda()(f (+ x 1)))))])
    (lambda()(f 0))))


(define (vector-assoc v vec)
  (letrec ([len (vector-length vec)]
           [f (lambda(n)(if (> n (- len 1))
                            #f
                            (let ([e (vector-ref vec n)])
                              (if (and (pair? e) (equal? (car e) v))
                                   e
                                  (f (+ 1 n))))))])
           (f 0)))
                              

(define (cached-assoc xs n)
  (letrec ([memo (make-vector n #f)]
        [pos 0])
        (lambda(v)(let ([ans (vector-assoc v memo)])
                    (if ans
                        ans
                        (let ([new-ans (assoc v xs)])
                              (begin
                                (vector-set! memo pos new-ans)
                                (set! pos (remainder (+ 1 pos) n))
                                new-ans)))))))
                      
                      
(define-syntax while-less
  (syntax-rules (do)
    [(while-less e1 do e2)
     (letrec ([f (lambda()(begin (let ([ret e2])
                                  (if (< ret e1)
                                      (f)
                                      #t))))])
       (f))]))
                          




























                












