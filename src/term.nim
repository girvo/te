## VT100/ANSI terminal handling

import os

## Load printf in from stdio to handle escapes correctly
proc printf(formatstr: cstring) {.header: "<stdio.h>", importc: "printf", varargs.}

proc esc*(code: string): string =
  ## Generates an escape-code sequence string
  result = "\x1b[" & code

proc clear*() =
  ## Clears the terminal
  printf(esc("2J") & esc(";H"))
