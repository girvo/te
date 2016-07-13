## A tiny editor written in Nim

import os, posix, strutils
import types
import editor
import term

proc main(e: EditorConfig) =
  # Setup with the initial size
  var size: TermSize = term.calcSize()
  e.size = size

  term.clear()
  write(stdout, "Testing...\r\n")
  signal(SIGWINCH, termResized)
  while true:
    discard

when isMainModule:
  main(editorInst)
