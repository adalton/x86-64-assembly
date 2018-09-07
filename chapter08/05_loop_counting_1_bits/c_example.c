/*
 * ex.c
 *
 * C implementaiton of the same code.  We can run this through gcc to produce
 * an assembly language representaiton of the same program and compare it
 * to our own.
 */
long data = 0xfedcba9876543210;
long sum = 0;

int main(void)
{
    register int i = 0;

    while (i < 64) {
        sum += data & 0x1;
        data >>= 1;
        ++i;
    }
    return 0;
}
