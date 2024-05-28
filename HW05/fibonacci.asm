;;=============================================================
;; CS 2110 - Spring 2024
;; Homework 5 - Fibonacci
;;=============================================================
;; Name: Katniss
;;=============================================================


;; Suggested Pseudocode (see PDF for explanation)
;;
;; n = mem[N];
;; resAddr = mem[RESULT]
;; 
;; if (n == 1) {
;;     mem[resAddr] = 0;
;; } else if (n > 1) {
;;     mem[resAddr] = 0;
;;     mem[resAddr + 1] = 1;
;;     for (i = 2; i < n; i++) {
;;         x = mem[resAddr + i - 1];
;;         y = mem[resAddr + i - 2];
;;         mem[resAddr + i] = x + y;
;;     }
;;

.orig x3000
    ;; YOUR CODE HERE
    LD R0, N        ;R0 = n = mem[N]
    LD R1, RESULT   ;R1 = resAddr = mem[RESULT]
    
    ADD R3, R0, #-1
    BRp POS     ;if n > 1
    BRn END     ;if n < 1, then end
    BRz ZERO
    
    ZERO
    ;for when n = 1
    AND R2, R2, #0   ;0 stored in R2
    STR R2, R1, #0   ;mem[resAddr] = 0
    BR END
    
    POS
    AND R2, R2, #0   ;0 stored in R2
    STR R2, R1, #0   ;mem[resAddr] = 0
    
    AND R3, R3, #0
    ADD R3, R3, #1
    STR R3, R1, #1   ;mem[resAddr + 1] = 1
    
    
    ;starting the for loop
    AND R4, R4, #0
    ADD R4, R4, #2      ;initialize value of i = 2
    
    FOR_LOOP
    LD R0, N
    NOT R7, R0          ;flip bits of N
    ADD R7, R7, #1      ;add 1 (neg -> pos in 2's complement)
    ADD R7, R4, R7      ;store (i-n) in new register
    
    ;BRn FOR_LOOP        ;if i < n, continue loop
    BRzp END         ;if i=n or i > n stop
    
    ;do everything inside for loop
    ADD R5, R1, R4      ;calculate address of mem[resAddr + i]
    LDR R6, R5, #-1     ;x = mem[resAddr + i - 1]
    LDR R7, R5, #-2     ;y = mem[resAddr + i - 2]
    
    ADD R7, R7, R6      ;calculate x + y
    STR R7, R5, #0      ;mem[resAddr + i] = x + y
    
    ;increment i
    ADD R4, R4, #1     ;increment i
    BR FOR_LOOP

    END
    HALT

;; Do not rename or remove any existing labels
;; You may change the value of N for debugging
N       .fill 5
RESULT  .fill x4000
.end

.orig x4000
.blkw 100
.end