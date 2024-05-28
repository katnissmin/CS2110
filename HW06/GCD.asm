;;=============================================================
;;  CS 2110 - Spring 2024
;;  Homework 6 - GCD
;;=============================================================
;;  Name: Katniss
;;============================================================

;;  In this file, you must implement the 'MOD' and 'GCD' subroutines.

.orig x3000
    ;; You do not need to write anything here
    LD R6, STACK_PTR

    ;; Pushes arguments A and B
    ADD R6, R6, -2
    LD R1, A
    STR R1, R6, 0
    LD R1, B
    STR R1, R6, 1 
    JSR GCD
    LDR R0, R6, 0
    ADD R6, R6, 3
    HALT

    STACK_PTR   .fill xF000
    ;; You can change these numbers for debugging!
    A           .fill 10
    B           .fill 4
    
    
;;  MOD Pseudocode (see PDF for explanation and examples)   
;;  
;;  MOD(int a, int b) {
;;      while (a >= b) {
;;          a -= b;
;;      }
;;      return a;
;;  }

MOD ;; Do not change this label! Treat this as like the name of the function in a function header
    ;; Code your implementation for the MOD subroutine here!
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
   
   LDR R0, R5, #4   ;R0 = a
   LDR R1, R5, #5   ;R1 = b
   
   MOD_WHILE
   NOT R3, R1       ;negating b
   ADD R3, R3, #1   ;2's complement of b
   ADD R2, R0, R3   ;a - b
   BRn MOD_END
   ADD R0, R2, #0   ;a -= b
   BR MOD_WHILE
   MOD_END


 	STR 	R0, R5, 3 	; save return value on stack

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

;;  GCD Pseudocode (see PDF for explanation and examples)
;;
;;  GCD(int a, int b) {
;;      if (b == 0) {
;;          return a;
;;      }
;;        
;;      while (b != 0) {
;;          int temp = b;
;;          b = MOD(a, b);
;;          a = temp;
;;      }
;;      return a;
;;  }

GCD ;; Do not change this label! Treat this as like the name of the function in a function header
    ;; Code your implementation for the GCD subroutine here!
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
   LDR R3, R5, #4   ;R3 = a
   LDR R0, R5, #5   ;R0 = b
   
GCD_IF
   ADD R0, R0, #0   ;is b = 0? if yes, go to end
   BRz GCD_END
   
   ADD R1, R0, #0   ;copy b to R1 (temp) 
   ADD R6, R6, #-2
   STR R0, R6, #1
   STR R3, R6, #0
   JSR MOD          ;MOD (a,b)
   LDR R0, R6, #0   ;b = MOD (a,b)
   ADD R6, R6, #3   ;pop args
   ADD R3, R1, #0   ;a = temp
   BR GCD_IF        ;if b != 0, restart the loop
GCD_END

 	STR 	R3, R5, 3 	; save return value on stack

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