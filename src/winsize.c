/**
 * Tiny bridge to ioctl to grab the TTY size for Nim
 */

#include <sys/ioctl.h>
#include <stdio.h>

typedef unsigned short ushort;

ushort getCols()
{
    struct winsize sz;

    if (ioctl(0, TIOCGWINSZ, &sz) == -1) {
        return 0;
    }

    return sz.ws_col;
}

ushort getRows()
{
    struct winsize sz;

    if (ioctl(0, TIOCGWINSZ, &sz) == -1) {
        return 0;
    }

    return sz.ws_row;
}
