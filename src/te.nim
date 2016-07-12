## A tiny editor written in Nim

import os
from ./term import nil

type
  FileInfo = ref object
    filename: string
    path: string
    dirty: bool

type
  EditorConfig = ref object
    ## Struct to hold useful data for our current editor/file
    cx: int
    cy: int
    rowOffset: int
    colOffset: int
    screenRows: int
    screenCols: int
    numRows: int
    filename: ref string
    file: ref FileInfo
    statusMessage: array[1..80, char]

proc newEditorConfig(): EditorConfig = result

# Actually setup our proper editorconfig object
let E = newEditorConfig()

proc main() =
  term.clear()
  term.clear()
  echo("Welcome...")

when isMainModule:
  main()
