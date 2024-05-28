/**
 * CS 2110 Spring 2024 HW1
 * Part 1 - Coding a bit vector
 *
 * @author Katniss
 *
 * Global rules for this file:
 * - You may not use multiplication, division or modulus in any method.
 * - You may not use more than 2 conditionals per method, and you may only use
 *   them in select methods. Conditionals are if-statements, if-else statements,
 *   or ternary expressions. The else block associated with an if-statement does
 *   not count toward this sum.
 * - You may not use looping constructs in most methods. Looping constructs
 *   include for loops, while loops and do-while loops. See below for exceptions
 * - In those methods that allow looping, you may not use more than 2 looping
 *   constructs, and they may not be nested.
 * - You may not declare any file-level variables.
 * - You may not declare any objects.
 * - You may not use switch statements.
 * - You may not use casting.
 * - You may not use the unsigned right shift operator (>>>)
 * - You may not write any helper methods, or call any method from this or
 *   another file to implement any method. Recursive solutions are not
 *   permitted.
 * - You may only perform addition or subtraction with the number 1.
 *
 * Method-specific rules for this file:
 * - All methods must be done in one line, except for: onesCount, leadingZerosCount,
 *   and isPalindrome.
 * - Looping and conditionals as described above are only allowed for:
 *   onesCount, leadingZerosCount, and isPalindrome.
 * - Subtraction with any number other than 1 is allowed for: isPalindrome
 */
public class BitVector {
    /**
     * 32-bit data initialized to all zeros. Here is what you will be using to
     * represent the Bit Vector. Do not change its scope from private.
     */
    private int bits;

    /** You may not add any more fields to this class other than the given one. */

    /**
     * Sets the bit (sets to 1) pointed to by index.
     *
     * @param index index of which bit to set.
     *              0 for the least significant bit (right most bit).
     *              31 for the most significant bit.
     */
    public void set(int index) {
        bits = bits | (1 << index);
    }

    /**
     * Clears the bit (sets to 0) pointed to by index.
     *
     * @param index index of which bit to set.
     *              0 for the least significant bit (right most bit).
     *              31 for the most significant bit.
     */
    public void clear(int index) {
        bits = bits & ~(1 << index);
    }

    /**
     * Toggles the bit (sets to the opposite of its current value) pointed to by
     * index.
     *
     * @param index index of which bit to set.
     *              0 for the least significant bit (right most bit).
     *              31 for the most significant bit.
     */
    public void toggle(int index) {
        bits = bits ^ (1 << index);
    }

    /**
     * Returns true if the bit pointed to by index is currently set.
     *
     * @param index index of which bit to check.
     *              0 for the least significant bit (right-most bit).
     *              31 for the most significant bit.
     * @return true if the bit is set, false if the bit is clear.
     * If the index is out of range (index >= 32), then return false.
     */
    public boolean isSet(int index) {
        // if (index >= 32) {
        //    return false;
        // } else {
        //     return (bits & (1 << index)) != 0;
        // }
        // one line version
        // return index >= 32 ? false : (bits & (1 << index)) != 0;
        return (index < 32) && ((bits & (1 << index)) != 0);
    }

    /**
     * Returns true if the bit pointed to by index is currently clear.
     *
     * @param index index of which bit to check.
     *              0 for the least significant bit (right-most bit).
     *              31 for the most significant bit.
     * @return true if the bit is clear, false if the bit is set.
     * If the index is out of range (index >= 32), then return true.
     */
    public boolean isClear(int index) {
        // if (index >= 32) {
        //     return true;
        // } else {
        //     return (bits & (1 << index)) == 0;
        // }
        // one line version
        // return index >= 32 ? false : (bits & (1 << index)) == 0;
        // return (index <= 32) && ((bits & (1 << index)) == 0);
        return index >= 32 || (bits & (0x1 << index)) == 0;
    }

    /**
     * Returns the number of bits currently set (=1) in this bit vector.
     * You may use the ++ operator to increment your counter.
     */
    public int onesCount()
    {
        int total = 0;
        for (int i = 0; i < 32; i++) {
            if ((bits & (0x1 << i)) != 0) {
                total ++;
            }
        }
        return total;
    }

    /**
     * Returns the number of zeroes to the left of the most significant 1 in this bit vector.
     * You may use the ++ operator to increment your counter.
     *
     * Ex: 000100000110000...0 -> 3
     */
    public int leadingZerosCount() {
        int total = 0;
        for (int i = 31; i >= 0; i--) {
            if ((bits & (1 << i)) != 0) {
                break;
            }
            total++;
        }
        return total;
    }

//        for (int i = 0; i < 32; i++) {
//            if ((bits & (0x1 << i)) == 0) {
//                total++;
//            } else {
//                return total;
//            }
//        }
//        return total;


    /**
     * Returns if the bit vector is a palindrome (reading it forwards is equivalent to reading it backwards)
     *
     * Ex: 011...110 -> true
     * Ex: 010...110 -> false
     */
    public boolean isPalindrome() {
        int left = 0;
        int right = 31;

        while (left < right) {
            if (((bits & (1 << left)) == 0) != ((bits & (1 << right)) == 0)) {
                return false;
            }
            left++;
            right--;
        }
        return true;
    }
}