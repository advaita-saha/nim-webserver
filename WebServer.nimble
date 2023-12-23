# Package

version       = "0.1.0"
author        = "Advaita Saha"
description   = "A simple web server API in Nim-Lang"
license       = "MIT"
srcDir        = "src"
bin           = @["WebServer"]


# Dependencies

requires "nim >= 1.4.4", "jester", "norm"
