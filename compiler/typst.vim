" Vim compiler file
" Compiler: typst

if exists("current_compiler")
    finish
endif
let current_compiler = 'typst'


if exists(":CompilerSet") != 2
    command -nargs=* CompilerSet setlocal <args>
endif
CompilerSet errorformat=%f:%l:%c:%m
CompilerSet makeprg=typst.exe\ compile\ --diagnostic-format\ 'short'\ %


