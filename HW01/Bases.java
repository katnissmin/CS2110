/**
 * CS 2110 Spring 2024 HW1
 * Part 2 - Coding with bases
 *
 * @author Katniss
 *
 * Global rules for this file:
 *
 * - You cannot use multiplication, division, and modulus operators
 * - You cannot use nested loops
 * - You cannot declare file-level variables
 * - You cannot use switch statements
 * - You cannot use the unsigned right shift operator (>>>)
 * - You cannot use helper methods, call any other methods, or use recursion.
 * 
 * - You may not use more than 2 conditionals per method. Conditionals are
 *   if-statements, if-else statements, or ternary expressions. The else block
 *   associated with an if-statement does not count toward this sum.
 * - You may not use more than 2 loops per method. This includes
 *   for loops, while loops and do-while loops.
 * - The only Java API methods you are allowed to invoke are:
 *     String.length()
 *     String.charAt()
 * - You may not invoke the above methods from String literals.
 *     Example: "12345".length()
 * - When concatenating numbers with Strings, you may only do so if the number
 *   is a single digit.
 */
public class Bases {
    /**
     * Convert a String containing ASCII characters (in binary) to an int.
     * <p>
     * You do not need to handle negative numbers. The Strings we will pass in
     * will be valid binary numbers, and able to fit in a 32-bit signed integer.
     * <p>
     * Example: binaryStringToInt("110"); // => 6
     */
    public static int binaryStringToInt(String binary) {
        int answer = 0;
        int length = binary.length();
        for (int i = length - 1; i >= 0; i--) {
            if (binary.charAt(i) == '1') {
                answer += 1 << length - (i + 1);
            }
        }
        return answer;
    }

    /**
     * Convert a String containing ASCII characters (in decimal) to an int.
     * <p>
     * You do not need to handle negative numbers. The Strings we will pass in
     * will be valid decimal numbers, and able to fit in a 32-bit signed integer.
     * <p>
     * Example: decimalStringToInt("46"); // => 46
     */
    public static int decimalStringToInt(String decimal) {
        int answer = 0;
        for (int i = 0; i < decimal.length(); i++) {
            int digit = decimal.charAt(i) - '0';
            answer = (answer << 3) + (answer << 1) + digit;
        }
        return answer;
    }

    /**
     * Convert a String containing ASCII characters (in binary) to an a String containing ASCII characters (in octal).
     * The input String will only contain the numbers 0 and 1.
     * You may assume that the length of the binary String is divisible by 3.
     * <p>
     * Example: binaryStringToOctalString("110100"); // => "64"
     */
    // octal - 0 to 7 --> represent 7
    // binary - 0 and 1 --> need 3 bits per every octal bit
    // break it into chunks of 3, convert each chunk into decimal
    // add each character/number
    public static String binaryStringToOctalString(String binary) {
        String answer = "";
        int decimal = 0;
        for (int i = 0; i < binary.length(); i += 3) {
            decimal = ((char) binary.charAt(i) - '0' << 2 |
                    (char) binary.charAt(i + 1) - '0' << 1 |
                    (char) binary.charAt(i + 2) - '0');
            answer += (char) (decimal + '0');
            decimal = 0;
        }
        return answer;
    }

    /**
     * Convert a int into a String containing ASCII characters (in hex).
     * <p>
     * You do not need to handle negative numbers.
     * The String returned should contain the minimum number of characters
     * necessary to represent the number that was passed in.
     * <p>
     * Example: intToHexString(30); // => "1E"
     */
    public static String intToHexString(int hex) {
        String answer = "";
        do {
            int rightmostHexDigit = hex & 0xF;
            answer = (char) (rightmostHexDigit < 10 ? rightmostHexDigit + '0' : rightmostHexDigit + 'A' - 10) + answer;
            hex = hex >> 4;
        } while (hex != 0);
        return answer;
    }

    /**
     * Convert a String containing ASCII characters representing a number in
     * hex into a String containing ASCII characters that represent that same
     * value in binary. The returned binary String should not have any leading
     * zeros, even if there are in the input hex String. If the hex String
     * evaluates to zero, then return the equivalent of zero in binary.
     * <p>
     * The output String should only 0's and 1's.
     * <p>
     * Example: hexStringToBinaryString("0F32A65C"); => "1111001100101010011001011100"
     */

    public static String hexStringToBinaryString(String hex) {
        // hex to int --> int to binary
        int total = 0;
        for (int i = 0; i < hex.length(); i++) {
            total = total << 4;
            total += (hex.charAt(i) > 64) ? hex.charAt(i) - 55 : hex.charAt(i) - 48;
        }
        if (total == 0) {
            return "0";
        }
        String answer = "";
        while (total != 0) {
            answer = (char) (48 + (total & 0b1)) + answer;
            total = total >> 1;
        }
        return answer;
    }
}





