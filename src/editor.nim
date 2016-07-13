## Main editor object

import os, posix, strutils
from ./term import TermSize

type
  FileInfo* = ref object
    filename*: string
    path*: string
    dirty*: bool

type
  EditorConfig* = ref object of RootObj
    ## Struct to hold useful data for our current editor/FileInfo
    cx*: Natural
    cy*: Natural
    size*: TermSize
    rowOffset*: Natural
    colOffset*: Natural
    numRows*: Natural
    filename*: string
    file*: FileInfo
    statusMessage*: array[1..80, char]

proc newEditorConfig*(): EditorConfig = new(result)

## The actual implementation
var
  editorInst*: EditorConfig = newEditorConfig()
