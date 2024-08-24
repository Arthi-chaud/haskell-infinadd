#pragma once

/**
 * Computes the estimated size of the buffer
 * that would receive the result of adding a and b
 */
ssize_t get_addition_max_len(char *a, const char *b);


/**
 * Computes the estimated size of the buffer
 * that would receive the result of adding a and b
 */
ssize_t get_substraction_max_len(char *a, const char *b);

/**
 * Adds the number stored in a to b
 */
char *add(const char *a, const char *b);

/**
 * Subs the number stored in a to b
 */
char *sub(const char *a, const char *b);
