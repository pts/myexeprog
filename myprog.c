#include <stdio.h>  /* Code below works without it. */

const int answer = (int)0x44434241;  /* dd 'ABCD' */

int mul(int a, int b) {
  return a * b + answer;
}

int main(int argc, char **argv) {
  (void)argv;
  return mul(argc, argc);
}
