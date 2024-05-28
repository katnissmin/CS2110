;;=============================================================
;;  CS 2110 - Spring 2024
;;  Homework 6 - DFS
;;=============================================================
;;  Name: Katniss
;;============================================================

;;  In this file, you must implement the 'SET_VISITED', 'IS_VISITED', and 'DFS' subroutines.


.orig x3000
    ;; You do not need to write anything here
    LD R6, STACK_PTR

    ;; Pushes arguments (address of node 1, target node 5)
    ADD R6, R6, -1
    AND R1, R1, 0
    ADD R1, R1, 5
    STR R1, R6, 0
    ADD R6, R6, -1
    LD R1, STARTING_NODE_ADDRESS
    STR R1, R6, 0
    JSR DFS
    LDR R0, R6, 0
    ADD R6, R6, 3
    HALT

    STACK_PTR .fill xF000
    STARTING_NODE_ADDRESS .fill x6110
    VISITED_VECTOR_ADDR .fill x4199 ;; stores the address of the visited vector.

;;  SET_VISITED Pseudocode

;; Parameter: The address of the node
;; Updates the visited vector to mark the given node as visited

;;  SET_VISITED(addr node) {
;;      visited = mem[mem[VISITED_VECTOR_ADDR]];
;;      data = mem[node];
;;      mask = 1;
;;      while (data > 0) {
;;          mask = mask + mask;
;;          data--;
;;      }
;;      mem[mem[VISITED_VECTOR_ADDR]] = (visited | mask); //Hint: Use DeMorgan's Law!
;;  }

SET_VISITED ;; Do not change this label! Treat this as like the name of the function in a function header
;; Code your implementation for the SET_VISITED subroutine here!
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
   LDR R0, R5, #4   ;R0 = address
   LDR R0, R0, #0   ;R0 = data = mem[node]
   AND R1, R1, #0   ;R1 = mask
   ADD R1, R1, #1   ;R1 = mask = 1
   LDI R2, VISITED_VECTOR_ADDR  ;R2 = visited = mem[mem[VISITED_VECTOR_ADDR]]
  
   START_WHILE1
   ADD R0, R0, #0   ;check if data > 0
   BRnz END_WHILE1
   ADD R1, R1, R1   ;mask = mask + mask
   ADD R0, R0, #-1  ;data--
   BR START_WHILE1
   END_WHILE1
   
   NOT R1, R1       ;-mask  = mask'
   NOT R2, R2       ;-visited = visited'
   AND R3, R2, R1   ;bitwise 
   NOT R3, R3       ;(visited' && mask')' = visited | mask
   STI R3, VISITED_VECTOR_ADDR  ;store value of R3 into VISITED_VECTOR_ADDR
   
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

;;  IS_VISITED Pseudocode

;; Parameter: The address of the node
;; Returns: 1 if the node has been visited, 0 if it has not been visited

;;  IS_VISITED(addr node) {
;;       visited = mem[mem[VISITED_VECTOR_ADDR]];
;;       data = mem[node];
;;       mask = 1;
;;       while (data > 0) {
;;           mask = mask + mask;
;;           data--;
;;       }
;;       return (visited & mask) != 0;
;;   }

IS_VISITED ;; Do not change this label! Treat this as like the name of the function in a function header
;; Code your implementation for the IS_VISITED subroutine here!
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
   LDR R0, R5, #4   ;R0 = address
   LDR R0, R0, #0   ;R0 = data = mem[node]
   AND R1, R1, #0   ;R1 = mask
   ADD R1, R1, #1   ;R1 = mask = 1
   LDI R2, VISITED_VECTOR_ADDR  ;R2 = visited = mem[mem[VISITED_VECTOR_ADDR]]
  
   START_WHILE2
   ADD R0, R0, #0   ;is data > 0?
   BRnz END_WHILE2  ;if no, end everything
   ADD R1, R1, R1   ;mask = mask + mask
   ADD R0, R0, #-1  ;data--
   BR START_WHILE2  ;continues as long as data > 0
   
   END_WHILE2
   AND R3, R2, R1   ;R3 = (R2 & R1) = (visited & mask)
   BRz ZERO         ;if R3 = (visited & mask), finish!
   
   AND R3, R3, #0   ;if R3 != (visited & mask)
   ADD R3, R3, #1   ;store 1 in return (meaning node has been visited & bit is set)
   
   ZERO
   STR R3, R5, #3   ;store return value in R5 + 3 
   
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

;;  DFS Pseudocode (see PDF for explanation and examples)

;; Parameters: The address of the starting (or current) node, the data of the target node
;; Returns: the address of the node (if the node is found), 0 if the node is not found

;;  DFS(addr node, int target) {
;;        SET_VISITED(node);
;;        if (mem[node] == target) {
;;           return node;
;;        }
;;        result = 0;
;;        for (i = node + 1; mem[i] != 0 && result == 0; i++) {
;;            if (! IS_VISITED(mem[i])) {
;;                result = DFS(mem[i], target);
;;            }
;;        }       
;;        return result;
;;  }

DFS ;; Do not change this label! Treat this as like the name of the function in a function header
    ;; Code your implementation for the DFS subroutine here!
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
   LDR R0, R5, #4   ;R0 = node
   ADD R6, R6, #-1  ;leave one space on stack to store 
   STR R0, R6, #0   ;R0 = R6 (stack pointer) (push address of current node onto stack)
   JSR SET_VISITED
   ADD R6, R6, #2   ;adjust SP back to og position
   
   LDR R1, R0, #0   ;R1 = mem[node]
   LDR R2, R5, #5   ;R2 = target
   NOT R2, R2       ;negate R2, 2's complement
   ADD R2, R2, #1   ;R2 = -target
   ADD R3, R1, R2   ;R3 = mem[node] - target
   BRnp DFS_ELSE1   ;if R3 != 0, continue to else
   STR R0, R5, #3   ;else return node
   BR TEARDOWN
   
   DFS_ELSE1        ;loop has 2 base conditions -> mem[i]!=0 and result==0
   AND R1, R1, #0   ;R1 = result = 0
   AND R2, R2, #0   ;R2 = i = 0
   ADD R2, R2, R0   ;R2 = i = node
   ADD R2, R2, #1   ;R2 = node + 1
  
   FOR_DFS
   LDR R3, R2, #0   ;R3 = mem[i]
   BRz DFS_END      ;if R3 = 0, end
   ADD R1, R1, #0
   BRnp DFS_END     ;if R1 != 0, end
   
   ADD R6, R6, #-1  ;if (! IS_VISITED(mem[i])) part
   STR R3, R6, #0
   JSR IS_VISITED
   LDR R4, R6, #0   ;load value at top of stack into R4
   ADD R6, R6, #2   ;adjust SP to next position after return value
   AND R4, R4, #0   ;need a R4 (for target)
   BRnp DFS_ELSE2
   ADD R6, R6, #-2  ;prepare stack for target and mem[i]
   LDR R4, R5, #5   ;R4 = target
   STR R4, R6, #1   ;push target onto stack
   STR R3, R6, #0   ;push mem[i] onto stack
   JSR DFS          ;recursive call if adjacent node isn't visited        
   LDR R1, R6, #0   ;load R6 into R1
   ADD R6, R6, #3   ;clean stack (move SP)
   
   DFS_ELSE2
   ADD R2, R2, #1   ;increment i (for loop)
   BR FOR_DFS 
   
   DFS_END
   STR R1, R5, #3   ;store result into R5
   
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

;; Assuming the graphs starting node (1) is at address x6100, here's how the graph (see below and in the PDF) is represented in memory
;;
;;         0      3
;;          \   / | \
;;            4   1 - 2 
;;             \ /    |
;;              5  -  6
;;

.orig x4199
    .fill 0 ;; visited set will be at address x4199, initialized to 0
.end

.orig x6110         ;; node 1 itself lives here at x6110
    .fill 1         ;; node.data (1)
    .fill x6120     ;; node 2 lives at this address
    .fill x6130     ;; node 3 lives at this address
    .fill x6150     ;; node 5 lives at this address   
    .fill 0
.end

.orig x6120	        ;; node 2 itself lives here at x6120
    .fill 2         ;; node.data (2)
    .fill x6110     ;; node 1 lives at this address
    .fill x6130     ;; node 3 lives at this address
    .fill x6160     ;; node 6 lives at this address
    .fill 0
.end

.orig x6130	        ;; node 3 itself lives here at x6130
    .fill 3         ;; node.data (3)
    .fill x6110     ;; node 1 lives at this address
    .fill x6120     ;; node 2 lives at this address
    .fill x6140     ;; node 4 lives at this address
    .fill 0
.end

.orig x6140	        ;; node 4 itself lives here at x6140
    .fill 4         ;; node.data (4)
    .fill x6100     ;; node 0 lives at this address
    .fill x6130     ;; node 3 lives at this address
    .fill x6150     ;; node 5 lives at this address
    .fill 0
.end

.orig x6100         ;; node 0 itself lives here at x6000
    .fill 0         ;; node.data (0)
    .fill x6140     ;; node 4 lives at this address
    .fill 0
.end

.orig x6150	        ;; node 5 itself lives here at x6150
    .fill 5         ;; node.data (5)
    .fill x6110     ;; node 1 lives at this address
    .fill x6140     ;; node 4 lives at this address
    .fill x6160     ;; node 6 lives at this address
    .fill 0
.end

.orig x6160	        ;; node 6 itself lives here at x6160
    .fill 6         ;; node.data (6)
    .fill x6120     ;; node 2 lives at this address
    .fill x6150     ;; node 5 lives at this address
    .fill 0
.end
 


