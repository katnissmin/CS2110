;;=============================================================
;; CS 2110 - Spring 2024
;; Homework 5 - uppercaseInRange 
;;=============================================================
;; Name: Katniss
;;=============================================================

;;  Suggested Pseudocode (see PDF for explanation)
;;  Pseudocode values are based on the labels' default values.
;;
;;  String str = "touppERcase";
;;  int start = mem[START];
;;  int end = mem[END];
;;  int length = mem[LENGTH];
;;  if (end > length) {
;;      end = length;
;;  }
;;
;;  for (int x = start; x < end; x++) {
;;      if (str[x] >= 'a') {
;;          str[x] = str[x] - 32;
;;      }
;;  }


.orig x3000
    ;; YOUR CODE HERE
    LD R0, STRING   ;R0 = STRING (String str = "touppERcase";)
    ; AND R1, R1, 0 ;resetting?
    LD R1, START    ;R1 = START index (int start = mem[START];)
    LD R2, END      ;R2 = END index (int end = mem[END];)
    LD R3, LENGTH   ;R3 = LENGTH of string (int length = mem[LENGTH];)
    
    ;if (end > length) {end = length}
    NOT R4, R3          ;flipping length
    ADD R4, R4, #1      ;add 1 to length
    ADD R4, R2, R4      ;store end - length in R4
    BRnz FOR_LOOP_START ;if neg or zero, go to for loop
    ADD R2, R3, 0       ;end = length 

    FOR_LOOP_START
    ADD R5, R1, 0   ;int x = start
    
    FOR_LOOP
    NOT R6, R5      ;flipping x, store into R6 (new register)
    ADD R6, R6, #1  ;add 1 to x
    ADD R6, R2, R6  ;store (-x) + end in R6
    BRnz FINISH
    
    ;address of str = R0
    ;find address of str[x]?
    ADD R6, R0, R5  ;find address by adding x to location of str
    LDR R7, R6, #0  ;get the value of str[x]
    
    LD R3, ASCII_A  ;R3 is now the ASCII value
    NOT R3, R3
    ADD R3, R3, #1
    ADD R7, R7, R3
    BRn INCREMENT
    
    LDR R7, R6, #0  ;
    ;do this if str[x]-'a'>=0
    ADD R4, R7, #-16  ;do -16 twice 
    ADD R4, R4, #-16  ;because -32 doesn't work
    ;need to store the str[x] value at address of str[x]
    STR R4, R6, #0

    INCREMENT
    ;increment x
    ADD R5, R5, #1     ;increment x
    BR FOR_LOOP
    
    FINISH
    HALT

;; Do not change these values!
STRING          .fill x5000
ASCII_A         .fill 97

;; You can change these numbers for debugging!
LENGTH          .fill 11
START           .fill 2
END             .fill 9

.end

.orig x5000                    ;;  Don't change the .orig statement
    .stringz "touppERcase"     ;;  You can change this string for debugging!
.end
