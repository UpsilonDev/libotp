Tasks:clean()

Tasks:minify "minify" {
  input = "build/libotp.lua",
  output= "build/libotp.min.lua"
}

Tasks:require "main" {
  include = "libotp/*.lua",
  startup = "libotp/main.lua",
  output = "build/libotp.lua"
}

Tasks:Task "build" { "clean", "minify" } :Description "Main build task"

Tasks:Default "main"
