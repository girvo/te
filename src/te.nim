## A tiny editor written in Nim

import os, posix, strutils
import types
import editor
import term

proc main(e: EditorConfig) =
  # Setup with the initial size
  var size: TermSize = term.calcSize()
  e.size = size

  signal(SIGWINCH, termResized)
  write(stdout, "Testing...\r\n")

  while true:
    discard

when isMainModule:
  main(editorInst)
