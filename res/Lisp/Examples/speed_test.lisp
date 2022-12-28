(def example [
0x00 0x00 0x00 0x00 0x0a 0x4b 0x0b 0x49 0x0b 0x48 0x10 0xb5 0x7b 0x44 0x07 0x4c 0x1b 0x68 0x23 0x68
0x79 0x44 0x78 0x44 0x98 0x47 0x08 0x49 0x08 0x48 0x23 0x68 0x79 0x44 0x78 0x44 0x98 0x47 0x01 0x20
0x10 0xbd 0x00 0xbf 0x00 0xf8 0x00 0x10 0xf0 0xff 0xff 0xff 0xc1 0x00 0x00 0x00 0x46 0x00 0x00 0x00
0x05 0x01 0x00 0x00 0x46 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
0x43 0x20 0x54 0x61 0x6b 0x52 0x65 0x73 0x3a 0x20 0x25 0x64 0x00 0x00 0x00 0x00 0x65 0x78 0x74 0x2d
0x64 0x65 0x63 0x2d 0x63 0x6e 0x74 0x00 0x65 0x78 0x74 0x2d 0x74 0x61 0x6b 0x00 0x82 0xb0 0x01 0x90
0x01 0x98 0x18 0xb1 0x01 0x98 0x01 0x38 0x02 0xb0 0xf7 0xe7 0x02 0xb0 0x70 0x47 0x30 0xb5 0x85 0xb0
0x03 0x90 0x02 0x91 0x01 0x92 0x02 0x9a 0x03 0x9b 0x9a 0x42 0x1a 0xda 0x03 0x98 0x02 0x99 0x01 0x9a
0x01 0x38 0xff 0xf7 0xf1 0xff 0x04 0x46 0x02 0x98 0x01 0x99 0x03 0x9a 0x01 0x38 0xff 0xf7 0xea 0xff
0x05 0x46 0x01 0x98 0x03 0x99 0x02 0x9a 0x01 0x38 0xff 0xf7 0xe3 0xff 0x29 0x46 0x02 0x46 0x20 0x46
0x05 0xb0 0xbd 0xe8 0x30 0x40 0xdb 0xe7 0x01 0x98 0x05 0xb0 0x30 0xbd 0x00 0x00 0x70 0xb5 0x01 0x29
0x2d 0xed 0x02 0x8b 0x05 0x46 0x10 0x4c 0x18 0xd1 0xe3 0x6f 0x00 0x68 0x98 0x47 0xa0 0xb1 0xd4 0xf8
0xac 0x30 0x98 0x47 0x63 0x6e 0x28 0x68 0xb0 0xee 0x40 0x8a 0x98 0x47 0xff 0xf7 0xb9 0xff 0xd4 0xf8
0xac 0x30 0x98 0x47 0x30 0xee 0x48 0x0a 0xbd 0xec 0x02 0x8b 0xe3 0x6c 0xbd 0xe8 0x70 0x40 0x18 0x47
0xbd 0xec 0x02 0x8b 0xd4 0xf8 0x94 0x00 0x70 0xbd 0x00 0xbf 0x00 0xf8 0x00 0x10 0x2d 0xe9 0xf0 0x41
0x03 0x29 0x2d 0xed 0x02 0x8b 0x05 0x46 0x1e 0x4c 0x35 0xd1 0xe3 0x6f 0x00 0x68 0x98 0x47 0x00 0x28
0x30 0xd0 0xe3 0x6f 0x68 0x68 0x98 0x47 0x60 0xb3 0xe3 0x6f 0xa8 0x68 0x98 0x47 0x40 0xb3 0xd4 0xf8
0xac 0x30 0x98 0x47 0x63 0x6e 0x28 0x68 0xb0 0xee 0x40 0x8a 0x98 0x47 0x63 0x6e 0x06 0x46 0x68 0x68
0x98 0x47 0x63 0x6e 0x07 0x46 0xa8 0x68 0x98 0x47 0x39 0x46 0x02 0x46 0x30 0x46 0xff 0xf7 0x86 0xff
0xd4 0xf8 0xac 0x30 0x05 0x46 0x98 0x47 0x0b 0x48 0xd4 0xf8 0xb4 0x30 0xf0 0xee 0x40 0x8a 0x29 0x46
0x78 0x44 0x98 0x47 0x38 0xee 0xc8 0x0a 0xbd 0xec 0x02 0x8b 0xe3 0x6c 0xbd 0xe8 0xf0 0x41 0x18 0x47
0xbd 0xec 0x02 0x8b 0xd4 0xf8 0x94 0x00 0xbd 0xe8 0xf0 0x81 0x00 0xf8 0x00 0x10 0xbc 0xfe 0xff 0xff
])

; Provides ext-dec-cnt and ext-tak which are implemented as recursive functions in C
; like below. They take the same arguments, but return the number of seconds they took
; to run
(load-native-lib example)

(defun dec-cnt (x)
    (if (= x 0) 0 (dec-cnt (- x 1)))
)

; Seems to run faster using match instead of if
(defun dec-cnt2 (x)
    (match x (0 0) (_ (dec-cnt2 (- x 1))))
)

(defun tak (x y z)
    (if (>= y x)
        z
        (tak
            (tak (- x 1) y z)
            (tak (- y 1) z x)
            (tak (- z 1) x y)
)))

(print "\nTesting dec-cnt...")
(looprange i 0 2
    (progn
        (print (str-from-n (+ i 1) "Try %d"))
        (print (str-from-n (ext-dec-cnt 100000) "C Time: %.5f s"))
        (define start (systime))
        (dec-cnt2 100000)
        (def time (secs-since start))
        (print (str-from-n time "LBM Time: %.3f s"))
        (print (str-from-n (/ time (ext-dec-cnt 100000)) "C Speed Diff: %.1f times"))
        (sleep 1)
))

(print "\nTesting tak...")
(looprange i 0 2
    (progn
        (print (str-from-n (+ i 1) "Try %d"))
        (print (str-from-n (ext-tak 18 12 6) "C Time: %.5f s"))
        (define start (systime))
        (define takres (tak 18 12 6))
        (def time (secs-since start))
        (print (str-from-n time "LBM Time: %.3f s"))
        (print (str-from-n (/ time (ext-tak 18 12 6)) "C Speed Diff: %.1f times"))
        (sleep 1)
))

; Results 2022-11-23
; dec-cnt: 245x faster in C
; tak: 156x faster in C