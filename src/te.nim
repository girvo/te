## A tiny editor written in Nim

import os, posix, strutils
import types
import editor
import term

proc main() =
  # Setup with the initial size
  var size: TermSize = term.calcSize()
  editorInst.size = size

  # Read the file in
  var file = newFileInfo("README.md", ".")
  editorInst.file = file
  editorInst.file.loadFile()

  signal(SIGWINCH, termResized)
  term.render()

  while true:
    discard

when isMainModule:
  main()
