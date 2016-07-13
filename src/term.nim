## ANSI escape-code based terminal handling
##
## This should avoid using curses if possible!

import os

type
  TermSize* = ref object
    ## TermSize definitions for our terminal cols and rows
    rows*, cols*: Natural

{.compile: "winsize.c".}
proc getCols(): cushort {.importc.}
proc getRows(): cushort {.importc.}

## Load printf in from stdio to handle escapes correctly
proc  printf(formatstr: cstring) {.header: "<stdio.h>", importc: "printf", varargs.}

## Instantiate a TermSize object with the given sizes
proc newTermSize*(rows: Natural, cols: Natural): TermSize =
  TermSize(rows: rows, cols: cols)

## Generates an escape-code sequence string
proc esc*(code: string): string =
  result = "\x1b[" & code

## Clears the terminal
proc clear*() =
  printf(esc("2J") & esc(";H"))

## Calculates the size of the terminal using ioctl
proc calcSize*(): TermSize =
  var
    cols = getCols()
    rows = getRows()
  newTermSize(rows, cols)
