## ANSI escape-code based terminal handling

import os, posix, strutils
import types
import editor

## C/POSIX bridges for TTY handling
{.compile: "winsize.c".}
proc getCols(): cushort {.importc.}
proc getRows(): cushort {.importc.}

## Load SIGWINCH from signals.h
var SIGWINCH* {.importc, header: "<signal.h>".}: cint

proc esc*(code: string): string =
  ## Generates an escape-code sequence string
  return "\x1b[" & code

proc clear*() =
  ## Clears the terminal to be ready for writing
  write(stdout, esc("2J") & esc("1;1H"))

proc calcSize*(): TermSize =
  ## Calculates the size of the terminal using ioctl via C functions
  var cols = getCols()
  var rows = getRows()
  return newTermSize(rows, cols)

proc render*() =
  term.clear()
  for row in editorInst.file.data:
    for ch in row:
      write(stdout, ch)
    write(stdout, "\r\n")

proc termResized*(x: cint) {.noconv.} =
  # Triggered by SIGWINCH signal on resize
  editorInst.size = calcSize()
  term.clear()
  term.render()
