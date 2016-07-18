## Main editor object

import os, posix, strutils
import types

## The actual implementation
var editorInst*: EditorConfig = newEditorConfig()

proc loadFile*(ed: EditorConfig, filename: string) =

