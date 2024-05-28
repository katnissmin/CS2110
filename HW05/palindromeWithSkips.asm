;;=============================================================
;; CS 2110 - Spring 2024
;; Homework 5 - palindromeWithSkips
;;=============================================================
;; Name: Katniss
;;=============================================================

;;  NOTE: Let's decide to represent "true" as a 1 in memory and "false" as a 0 in memory.
;;
;;  Pseudocode (see PDF for explanation)
;;  Pseudocode values are based on the labels' default values.
;;
;;  String str = "aibohphobia";
;;  char skipChar = mem[mem[CHARADDR]];
;;  int length = 0;
;;  while (str[length] != '\0') {
;;		length++;
;;	}
;; 	
;;	int left = 0;
;;  int right = length - 1;
;;  boolean isPalindrome = true;
;;  while(left < right) {
;;      if (str[left] == skipChar) {
;;          left++;
;;          continue;
;;      }
;;      if (str[right] == skipChar) {
;;          right--;
;;          continue;
;;      }
;;		if (str[left] != str[right]) {
;;			isPalindrome = false;
;;          break;
;;		}
;;
;;		left++;
;;		right--;
;;	}
;;	mem[mem[ANSWERADDR]] = isPalindrome;

.orig x3000
	;; YOUR CODE 
	LD R0, STRING   ;R0 = STRING (string hexString = "F1ED");
	
	LD R1, CHARADDR ;R1 = char skipChar = mem[mem[CHARADDR]];
	
	AND R2, R2, #0  ;resetting R2
	ADD R2, R2, #0  ;R2 = length (int length = 0;)
	
	;setting the while condition (str[length] != ’\0’)
	WHILE1
	ADD R0, R0, R2  ;R0 = address of STRING(R0) + length(R2)
	LDR R0, R0, #0  ;R0 = str[length]
	BRz END1
	
	END1
	AND R3, R3, #0  ;reset R3, R3 = left (int left = 0)
	AND R4, R4, #0  ;reset R4
	ADD R4, R2, R4  ;R4 = right = length(R2) (for now)
	ADD R4, R4, #-1 ;R4 = right (int right = length - 1)
	AND R5, R5, 0   ;reset R5
	ADD R5, R5, #1  ;R5 = TRUE (boolean isPalindrome = true;)
	
	;set the second while condition (left < right)
	WHILE2
	LD R0, STRING   ;R0 = STRING (string hexString = "F1ED");
	NOT R6, R4      ;negate RIGHT(R4)
	ADD R6, R6, #1  ;add 1 to R4 (makes -right)
	ADD R6, R3, R6  ;R6 = left - right
	BRzp END2
	
	ADD R6, R4, R0
	LDR R6, R6, #0  ;R6 = STR[RIGHT]
	
	ADD R7, R3, R0
	LDR R7, R7, #0  ;R7 = STR[LEFT]
	
	;set IF for str[left] == skipChar
	IF1
	ADD R2, R1, R7  ;R2 = str[left] - skipChar
	;if str[left] - skipChar = 0, increment left
	BRnp IF2
	ADD R3, R3, #1  ;left ++ (increment left)
	BR WHILE2
	
	;set IF for str[right] == skipChar
	IF2
	ADD R2, R1, R6  ;R2 = str[right] - skipChar
	;if str[right] - skipChar = 0, decrement right
	ADD R4, R3, #-1 ;right-- (decrement right)
	BRnp IF3
	BR WHILE2
	
	;set IF for str[left] != str[right]
	IF3
	NOT R7, R7      ;negate R7(str[left])
	ADD R7, R5, #1  ;add 1 to R7
	ADD R7, R5, R7  ;str[left] - str[right] = 0?
	BRz ENDIF3
	AND R5, R5, #0  ;set R5 = isPalindrome = FALSE
	BR END2
	
	ENDIF3
	ADD R3, R3, #1      ;increment left
	ADD R4, R4, #-1     ;decrement right
	BR WHILE2
	
	END2
	STI R5, ANSWERADDR  ;mem[mem[ANSWERADDR]] = isPalindrome; 
	HALT
	
;; Do not change these values!
CHARADDR    .fill x4004
STRING	    .fill x4019
ANSWERADDR 	.fill x5005
.end

;; Do not change any of the .orig lines!

.orig x4004
    .stringz "b"            ;;Feel free to change this char for debugging
.end

.orig x4019				   
	.stringz "F1ED"         ;; Feel free to change this string for debugging.
.end

.orig x5005
	ANSWER  .blkw 1         ;;Do not change this value
.end