## ANSI escape-code based terminal handling
##
## @see {http://stackoverflow.com/questions/8476332/writing-a-real-interactive-terminal-program-like-vim-htop-in-c-c-witho}

import os, posix, strutils, posix/termios
import types
import editor

## C/POSIX bridges for TTY handling
{.compile: "winsize.c".}
proc getCols(): cushort {.importc.}
proc getRows(): cushort {.importc.}

var
  original*: Termios
  raw*: Termios

## Load SIGWINCH from signals.h
var SIGWINCH* {.importc, header: "<signal.h>".}: cint

proc esc*(code: string): string =
  ## Generates an escape-code sequence string
  return "\x1b[" & code

proc writeEsc*(code: string) =
  ## Writes the escape code out via POSIX layer
  discard posix.write(STDOUT_FILENO, cstring(esc(code)), 6)

proc moveCursor*(line: Natural, column: Natural) =
  write(stdout, esc($line & ';' & $column & 'H'))

proc clear*() =
  ## Clears the terminal to be ready for writing
  moveCursor(0, 0)
  write(stdout, esc("2J") & esc("1;1H"))

proc calcSize*(): TermSize =
  ## Calculates the size of the terminal using ioctl via C functions
  var cols = getCols()
  var rows = getRows()
  return newTermSize(rows, cols)

proc setup*() =
  ## Sets up the terminal to use raw STDIN, and "fullscreen" mode
  discard tcGetAttr(STDIN_FILENO, addr(original))
  cfMakeRaw(addr(raw))
  discard tcSetAttr(STDIN_FILENO, TCSANOW, addr(raw))
  ## Switch to alternate buffer...
  writeEsc("?47h")

proc cleanup*() =
  ## Cleans up and re-sets the terminal on close
  writeEsc("?91")
  writeEsc("?471")
  discard tcSetAttr(STDIN_FILENO, TCSANOW, addr(original))

proc render*() =
  moveCursor(0, 0)
  # for y in 1..editorInst.size.rows:
  #   for x in 1..editorInst.size.cols:
  #     write(stdout, "a")
  #   if y != editorInst.size.rows - 1:
  #     write(stdout, "\r\n")
  #   else:
  #     moveCursor(0, 0)
  # for row in editorInst.file.data:
  #   for ch in row:
  #     write(stdout, ch)
  #   write(stdout, "\r\n")

proc termResized*(x: cint) {.noconv.} =
  # Triggered by SIGWINCH signal on resize
  editorInst.size = calcSize()
  term.render()
