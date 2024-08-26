#include<stdlib.h>
#include<string.h>
#include<stdbool.h>

static void swap(char *a, char *b) {
	char tmp = *a;

	*a = *b;
	*b = tmp;
}

static char *strrev(char *str) {
	char tmp = 0;
	const size_t len = strlen(str);
	for (size_t i = 0; i < len / 2; i++) {
		swap(&str[i], &str[len - 1 - i]);
	}
	return str;
}

static int digit_to_int(char c) {
	return c - '0';
}

// We consider a and b to have at most one leading '-'
size_t get_addition_max_len(const char *a, const char *b) {
  size_t max_len = 0;
  const size_t len_a = strlen(a);
  const size_t len_b = strlen(b);
  const bool a_is_neg = a[0] == '-';
  const bool b_is_neg = b[0] == '-';
  const size_t absolute_a_len = a_is_neg ? len_a - 1 : len_a;
  const size_t absolute_b_len = b_is_neg ? len_b - 1 : len_b;
  
  if (absolute_a_len > absolute_b_len) {
	  max_len = absolute_a_len;
  } else {
	  max_len = absolute_b_len + 1;
  }

  // 99 + 9 = 108 => need 1 more digit
  // 9 + 9 = 18 => need 1 more digit
  max_len += 1;
  max_len += (a_is_neg || b_is_neg) ? 1 : 0;
  return max_len;
}

char *sub(char *dest, const char *a, const char *b) {
	return dest;
}

// We expect dest to be filled with zero;
char *add(char *dest, const char *a, const char *b) {
  const bool a_is_neg = a[0] == '-';
  const bool b_is_neg = b[0] == '-';
  const char *absolute_a = a_is_neg ? &a[1] : a;
  const char *absolute_b = b_is_neg ? &b[1] : b;
  char *rev_a = strrev(strdup(absolute_a));
  char *rev_b = strrev(strdup(absolute_b));
  size_t absolute_a_len = strlen(absolute_a);
  size_t absolute_b_len = strlen(absolute_b);
  size_t max_len = absolute_a_len > absolute_b_len ? absolute_a_len : absolute_b_len;
  int hold = 0; // retenue;
  int op_tmp = 0;
  int left = 0;
  int right = 0;

  if (a_is_neg && !b_is_neg) {
	  return sub(dest, b, &a[1]);
  }
  if (b_is_neg && !a_is_neg) {
	  return sub(dest, a, &b[1]);
  }
  for (size_t i = 0; i < max_len; i++) {
	left = i < absolute_a_len ? digit_to_int(rev_a[i]) : 0;
	right = i < absolute_b_len ? digit_to_int(rev_b[i]) : 0;
	op_tmp = left + right + hold;
	if (op_tmp > 9) {
		hold = op_tmp / 10;
		op_tmp = op_tmp % 10;
	} else {
		hold = 0;
	}
	dest[strlen(dest)] = op_tmp + '0'; 
	op_tmp = digit_to_int(rev_b[i]) + hold;
  }
  if (hold) {
	  dest[strlen(dest)] = hold + '0';
  }
  if (a_is_neg && b_is_neg) {
	  dest[strlen(dest)] = '-';
  }
  return strrev(dest);
}

size_t get_substraction_max_len(const char *a, const char *b) {
	return get_addition_max_len(a, b);
}

