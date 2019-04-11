/*

> gcc binary_gap.s binary_gap_main.c
> ./a.out

*/

#include <stdio.h>
#include <inttypes.h>

int16_t binary_gap(int32_t);

int main() {
    printf("%d\n", binary_gap(1041));
    printf("%d\n", binary_gap(32));
    return 0;
}
