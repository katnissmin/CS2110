;;=============================================================
;;  CS 2110 - Spring 2024
;;  Homework 6 - isPalindrome
;;=============================================================
;;  Name: Katniss
;;============================================================

;;  In this file, you must implement the 'isPalindrome' subroutine.
 

.orig x3000
    ;; You do not need to write anything here
    LD R6, STACK_PTR

    ;; Pushes arguments (word addr and len)
    ADD R6, R6, -2
    LEA R0, STRING
    LD R1, LENGTH
    STR R0, R6, 0
    STR R1, R6, 1
    JSR IS_PALINDROME
    LDR R0, R6, 0
    ADD R6, R6, 3
    HALT
    STACK_PTR .fill xF000
    LENGTH .fill 5                 ;; Change this to be length of STRING
    STRING .stringz "rotor"	       ;; You can change this string for debugging!


;;  IS_PALINDROME **RECURSIVE** Pseudocode
;;
;;  isPalindrome(word (addr), len) { 
;;      if (len == 0 || len == 1) {
;;          return 1;
;;      } else {
;;          if (word[0] == word[len - 1]) {
;;              return IS_PALINDROME(word + 1, len - 2);
;;          } else { 
;;              return 0;
;;          }
;;      }
;;  }
;;
IS_PALINDROME ;; Do not change this label! Treat this as like the name of the function in a function header
    ;; Code your implementation for the isPalindrome subroutine here!
    ;; NOTE: Your implementation MUST be done recursively
    ADD 	R6, R6, -4 	; Allocate space for the fixed part of the stack frame
 	STR 	R7, R6, 2 	; Save Ret Addr
 	STR 	R5, R6, 1 	; Save Old FP
 	ADD 	R5, R6, 0 	; Copy SP to FP

		; The following 6 lines must be adjusted if you have more than one
		; local variable.  Increase the absolute value of the third operand
		; by the number of additional local variables you add, e.g. if you add
		; 2 local variables, the third operands on the lines below should be
		; -7, -3, -4, -5, -6, -7, respectively.
 	ADD 	R6, R6, -5 	; Make room for saved regs & l.v. 1-n
	STR  	R0, R5, -1 	; Save R0 
 	STR  	R1, R5, -2 	; Save R1
 	STR  	R2, R5, -3 	; Save R2
 	STR  	R3, R5, -4 	; Save R3
 	STR  	R4, R5, -5 	; Save R4
		; Your return value is addressed as FP, 3
		; Local variables are addressed as FP, 0; FP, -1; FP, -2; etc.

 ;====== DO WORK OF SUBROUTINE HERE =============
   ; Put the return value into some register, e.g. R0
   ;returning R4 into R5
   ;LDR: Load the value from memory at address (R5 + 4) into R0
   LDR R0, R5, #4   ;R0 = word(addr)
   LDR R1, R5, #5   ;R1 = len
   
   BRnp IF0         ;if len<0 or len>0
   BR IF1           ;else len == 0
   
   IF0              ;if BRnp IF0
   ADD R4, R1, #-1
   BRnp ELSE1
   BR IF1
   
   IF1
   AND R2, R2, #0   ;R2 = 0
   ADD R2, R2, #1   ;R2 = 1
   STR R2, R5, #3   ;store value of R2 (1) into R5 + 3
   BR TEARDOWN      ;clean stack
   
   ELSE1            
   LDR R2, R0, #0   ;load R0 to R2
   ADD R3, R0, R1   ;R3 = R0 + R1 = word + len
   ADD R3, R3, #-1  ;R3 = R3 - 1 = word + len -1
   LDR R4, R3, #0   ;R4 = word[len - 1]
   
   NOT R4, R4
   ADD R4, R4, #1
   ADD R4, R2, R4   ;word[0] - word[len-1]
   BRnp ELSE2
   
   ADD R0, R0, #1   ;move word pointer -> next character
   ADD R1, R1, #-2  ;len - 2    
   ADD R6, R6, #-2  ;stack pointer down 2
   STR R0, R6, #0   ;R0 is now updated word pointer 
   STR R1, R6, #1   ;R1 is now updated len
   
   JSR IS_PALINDROME    ;recursive call
   LDR R4, R6, #0   ;load R4 with recursive call value
   STR R4, R5, #3   ;save result in memory
   BR TEARDOWN
   
   ELSE2
   AND R4, R4, #0   ;R4 = 0
   STR R4, R5, #3   ;save result in memory
   ADD R6, R6, #3
   BR TEARDOWN
   
   TEARDOWN
		; The following 5 lines must be adjusted if you have more than one
		; local variable.  Increase the absolute value of the third operand
		; by the number of additional local variables you add, e.g. if you add
		; 2 local variables, the third operands on the lines below should be
		; -7. -6, -5, -4, -3, respectively.
 	LDR 	R4, R5, -5	; Restore R4
 	LDR 	R3, R5, -4 	; Restore R3
 	LDR 	R2, R5, -3 	; Restore R2
 	LDR 	R1, R5, -2 	; Restore R1
 	LDR 	R0, R5, -1 	; Restore R0

 	ADD 	R6, R5, 0 	; Restore SP
 	LDR 	R5, R6, 1 	; Restore FP
 	LDR 	R7, R6, 2 	; Restore RA
 	ADD 	R6, R6, 3 	; Pop RA,FP,1st local variable
 	
    RET
.end