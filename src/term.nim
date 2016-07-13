## ANSI escape-code based terminal handling

import os, posix, strutils

## C/POSIX bridges for TTY handling
{.compile: "winsize.c".}
proc getCols(): cushort {.importc.}
proc getRows(): cushort {.importc.}

## Load SIGWINCH from signals.h
var SIGWINCH* {.importc, header: "<signal.h>".}: cint

## Module implementation

type
  TermSize* = ref object
    ## TermSize definitions for our terminal cols and rows
    rows*, cols*: Natural

## Instantiate a TermSize object with the given sizes
proc newTermSize*(rows: Natural, cols: Natural): TermSize =
  TermSize(rows: rows, cols: cols)

## Generates an escape-code sequence string
proc esc*(code: string): string =
  result = "\x1b[" & code

## Clears the terminal
proc clear*() =
  write(stdout, esc("2J") & esc(";H"))

## Calculates the size of the terminal using ioctl
proc calcSize*(): TermSize =
  var
    cols = getCols()
    rows = getRows()
  newTermSize(rows, cols)

proc termResized*(x: cint) {.noconv.} =
  discard
