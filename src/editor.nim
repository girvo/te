## Main editor object

import os, posix, strutils, sequtils
import types

## The actual implementation
var editorInst*: EditorConfig = newEditorConfig()

proc loadFile*(fileInfo: var types.FileInfo) =
  fileInfo.data = @[]
  try:
    var file = readFile(fileInfo.filename)
    var lineNo = 0
    for line in splitLines(file):
      var rowSeq: seq[char] = @[]
      for i in 0..len(line):
        rowSeq.insert(line[i], i)
      fileInfo.data.insert(rowSeq, lineNo)
      lineNo = lineNo + 1
  except IOError:
    echo("IOError...")
    discard
  except:
    echo("Another error...")
    raise
