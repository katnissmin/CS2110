/**
 * @file my_string.c
 * @author Katniss
 * @brief Your implementation of the famous string.h library functions!
 *
 * NOTE: NO ARRAY NOTATION IS ALLOWED IN THIS FILE
 *
 * @date 2024-03-20
 */

#include "my_string.h"

/* Note about UNUSED_PARAM
*
* UNUSED_PARAM is used to avoid compiler warnings and errors regarding unused function
* parameters prior to implementing the function. Once you begin implementing this
* function, you can delete the UNUSED_PARAM lines.
*/

/**
 * @brief Calculate the length of a string
 *
 * @param s a constant C string
 * @return size_t the number of characters in the passed in string
 */
size_t my_strlen(const char *s)
{
    int count = 0;
    while (*s != '\0') {
        count++;
        s++;
    }
    return count;
}

/**
 * @brief Compare two strings
 *
 * @param s1 First string to be compared
 * @param s2 Second string to be compared
 * @param n First (at most) n bytes to be compared
 * @return int representing the difference between the strings:
 *          - 0 if the strings are equal
 *          - arbitrary positive number if s1 > s2
 *          - arbitrary negative number if s1 < s2
 */
int my_strncmp(const char *s1, const char *s2, size_t n)
{
    size_t pos = 0;
    char curr1 = *s1;
    char curr2 = *s2;
    while (pos < n) {
        curr1 = *(s1 + pos);
        curr2 = *(s2 + pos);
        if (curr1 == '\0') {
            return curr1 - curr2;
        }
        if (curr1 != curr2) {
            return curr1 - curr2;
        }
        pos = pos + 1;
    }
    return curr1 - curr2;
}

/**
 * @brief Copy a string
 *
 * @param dest The destination buffer
 * @param src The source to copy from
 * @param n maximum number of bytes to copy
 * @return char* a pointer same as dest
 */
char *my_strncpy(char *dest, const char *src, size_t n)
{
    size_t counter = 0;
    char* pointer = dest;
    while (counter < n) {
        *dest = *src;
        dest++;
        src++;
        counter++;
    }
    return pointer;
}

/**
 * @brief Concatenates two strings and stores the result
 * in the destination string
 *
 * @param dest The destination string
 * @param src The source string
 * @param n The maximum number of bytes (or characters) from src to concatenate
 * @return char* a pointer same as dest
 */
char *my_strncat(char *dest, const char *src, size_t n)
{
    char *curr = dest;
    while (*curr != '\0') {
        curr = curr + 1;
    }
    size_t pos = 0;
    while (pos < n) {
        if (*(src + pos) == '\0') {
            break;
        }
        *(curr + pos) = *(src + pos);
        pos++;
    }
    *(curr + pos) = '\0';
    return dest;
}

/**
 * @brief Copies the character c into the first n
 * bytes of memory starting at *str
 *
 * @param str The pointer to the block of memory to fill
 * @param c The character to fill in memory
 * @param n The number of bytes of memory to fill
 * @return char* a pointer same as str
 */
void *my_memset(void *str, int c, size_t n)
{
    size_t pos = 0;
    char *str1 = str;
    while (pos < n) {
        *(str1 + pos) = (char) c;
        pos++;
    }
    return str;
}

/**
 * @brief Checks whether the string is a palindrome
 * (i.e., reads the same forwards and backwards)
 * assuming that the case of letters is irrelevant.
 * 
 * @param str The pointer to the string
 * @return 1 if the string is a palindrome,
 * or 0 if the string is not
*/
int is_palindrome_ignore_case(const char *str) 
{
    if (str == NULL || *str == '\0') {
        return 1;
    }

    const char *start = str;
    const char *end = str + my_strlen(str) - 1;

    while (start < end) {
        char start_char;
        char end_char;

        if (*start >= 'A' && *start <= 'Z') {
            start_char = *start + 32;
        } else {
            start_char = *start;
        }

        if (*end >= 'A' && *end <= 'Z') {
            end_char = *end + 32;
        } else {
            end_char = *end;
        }

        if (start_char != end_char) {
            return 0;
        }

        start++;
        end--;
    }
    return 1;
}

/**
 * @brief Apply a Caesar shift to each character
 * of the provided string in place.
 * 
 * @param str The pointer to the string
 * @param shift The amount to shift by
*/
void caesar_shift(char *str, int shift) 
{
    while (*str != '\0') {
        if ((*str >= 'a' && *str <= 'z') || (*str >= 'A' && *str <= 'Z')) {
            char base;
            if (*str >= 'a' && *str <= 'z') {
                base = 'a';
            } else {
                base = 'A';
            }
            *str = base + ((*str - base + shift) % 26);
        }
        str++;
    }
}

/**
 * @brief Mutate the string in-place to
 * remove duplicate characters that appear
 * consecutively in the string.
 * 
 * @param str The pointer to the string
*/
void deduplicate_str(char *str) 
{
    if (str == NULL || *str == '\0') {
        return;
    }

    char *write = str;
    char *read = str;

    while (*read != '\0') {
        if (*read != *write) {
            write++;
            *write = *read;
        }
        read++;
    }
    write++;
    *write = '\0';
}

/**
 * @brief Swap the position of
 * two strings in memory.
 * 
 * @param s1 The first string
 * @param s2 The second string
*/
void swap_strings(char **s1, char **s2) 
{
    char *temp = *s1;
    *s1 = *s2;
    *s2 = temp;

    return;
}