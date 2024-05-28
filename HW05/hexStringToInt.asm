;;=============================================================
;; CS 2110 - Spring 2024
;; Homework 5 - hexStringToInt
;;=============================================================
;; Name: Katniss
;;=============================================================

;;  Suggested Pseudocode (see PDF for explanation)
;;  Pseudocode values are based on the labels' default values.
;;
;;  String hexString = "F1ED";
;;  int length = mem[LENGTH];
;;  int value = 0;
;;  int i = 0;
;;  while (i < length) {
;;      int leftShifts = 4;
;;      while (leftShifts > 0) {
;;          value += value;
;;          leftShifts--;
;;      }
;;      if (hexString[i] >= 65) {
;;          value += hexString[i] - 55;
;;      } else {
;;          value += hexString[i] - 48;
;;      }
;;      i++;
;;  }
;;  mem[mem[RESULTADDR]] = value;

.orig x3000
    ;; YOUR CODE HERE
    LD R0, HEXSTRING    ;R0 = HEXSTRING (String hexString = "F1ED";)
    ;for reference, resetting (AND R0, R0, #0)
    LD R1, LENGTH       ;R1 = LENGTH
    AND R2, R2, #0      ;reset R2     
    ADD R2, R2, #0      ;R2 = value (int value = 0;)
    AND R3, R3, #0      ;reset R3
    ADD R3, R3, #0      ;R3 = i (int i = 0;) // initialize value of i = 0
    
    ;while loop starts
    WHILE1
    ;when i - length > 0, go to the end
    NOT R4, R1          ;negate LENGTH
    ADD R4, R4, #1      ;add 1 to LENGTH
    ADD R4, R3, R4      ;check if R4 = i - length < 0
    BRzp FINISH
    AND R5, R5, #0
    ADD R5, R5, #4      ;leftshifts = 4
    
    WHILE2
    ADD R5, R5, #0      ;leftshifts = 4
    BRnz ENDWHILE2
    ADD R2, R2, R2      ;value += value
    ADD R5, R5, #-1     ;leftshifts --
    BR WHILE2
    
    ENDWHILE2
    ;start if (hexString[0] >= 65)
    IF
    ADD R6, R0, R3      ;R6 = hexString[i]
    LDR R6, R6, #0
    AND R7, R7, #0
    ADD R7, R7, #-16
    ADD R7, R7, #-16
    ADD R7, R7, #-16
    ADD R7, R7, #-16
    ADD R7, R7, #-1     ;make R7 = -65
    ADD R7, R6, R7      ;R7 = hexString[i] - 65 (use previous R7) >= ?
    BRn ELSE
    
    ADD R7, R7, #10     ;R7 = hexString[i] - 55
    ADD R2, R7, R2      ;value += hexString[i] - 55
    BR END_IF
    
    ELSE
    ADD R7, R7, #15     ;R7 =hexString[i] - 48
    ADD R7, R7, #2
    ADD R2, R7, R2      ;value += hexString[i] - 48;
    
    END_IF
    ADD R3, R3, #1      ;i++
    BR WHILE1
    
    FINISH
    STI R2, RESULTADDR  ;mem[mem[RESULTADDR]] = value;
    
    HALT
    
;; Do not change these values!
ASCIIDIG        .fill 48
ASCIICHAR       .fill 55
SIXTYFIVE       .fill 65
HEXSTRING       .fill x5000
LENGTH          .fill 4
RESULTADDR      .fill x4000
.end

.orig x4000                    ;;Don't change the .orig statement
    ANSWER .blkw 1             ;;Do not change this value
.end


.orig x5000                    ;;  Don't change the .orig statement
    .stringz "F1ED"            ;;  You can change this string for debugging! Hex characters will be uppercase.
.end
