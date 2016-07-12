# Package

version       = "0.1.0"
author        = "Josh Girvin <josh@jgirvin.com>"
description   = "A tiny editor in Nim"
license       = "MIT"

# Dependencies

requires "nim >= 0.14.3"

srcDir = "src"
binDir = "build"
bin = @["te"]