#pragma once

#include <stdlib.h>

/**
 * Computes the estimated size of the buffer
 * that would receive the result of adding a and b
 */
size_t get_addition_max_len(const char *a, const char *b);

/**
 * Computes the estimated size of the buffer
 * that would receive the result of adding a and b
 */
size_t get_substraction_max_len(const char *a, const char *b);

/**
 * Adds the number stored in a to b
 * Sets the result in dest
 */
char *add(char *dest, const char *a, const char *b);

/**
 * Subs the number stored in a to b
 * Sets the result in dest
 */
char *sub(char *dest, const char *a, const char *b);
