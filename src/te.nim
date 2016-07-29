## A tiny editor written in Nim

import os, posix, posix/termios, strutils
import types
import editor
import term

var
  buff*: array[6, char]
  cont: bool = true

proc handleSigQuit(dummy: cint) {.noconv.} =
  cont = false

proc main() =
  # Setup with the initial size
  var size: TermSize = term.calcSize()
  editorInst.size = size

  # Read the file in
  var file = newFileInfo("README.md", ".")
  editorInst.file = file
  editorInst.file.loadFile()
  # term.clear()
  term.setup()

  signal(SIGINT, handleSigQuit)
  signal(SIGWINCH, termResized)
  term.render()

  while cont:
    discard read(STDIN_FILENO, addr(buff), 1)
    if buff[0] == 'q':
      cont = false
      break

when isMainModule:
  main()
  term.cleanup()
