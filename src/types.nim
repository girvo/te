## Type definitions (to avoid circular references)

type
  FileInfo* = ref object
    ## File information object
    filename*: string
    path*: string
    dirty*: bool
    data*: seq[seq[char]]

type
  TermSize* = ref object
    ## TermSize definitions for our terminal cols and rows
    rows*, cols*: Natural

type
  EditorConfig* = ref object
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

## Constructors

proc newTermSize*(rows: Natural, cols: Natural): TermSize =
  ## Instantiate a TermSize object with the given sizes
  TermSize(rows: rows, cols: cols)

proc newEditorConfig*(): EditorConfig = new(result)

proc newFileInfo*(filename: string, path: string): FileInfo =
  FileInfo(
    filename: filename,
    path: path,
    dirty: false,
    data: @[@['\0']])
