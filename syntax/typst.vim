vim9script

# Vim syntax file
# Language: Typst
# Latest Revision: Jan 2025

syntax sync fromstart

syntax match TypstHeader /^=\+\s\+.*$/ containedin=ALLBUT,TypstComment
highlight TypstHeader ctermfg=White cterm=bold,underline guifg=#FFFFFF gui=bold,underline

# Define the syntax for commands
# syntax match TypstCommand /\v#\w+.*/ containedin=ALLBUT,TypstComment
# highlight TypstCommand ctermfg=Yellow guifg=#FFFF00

# Define the syntax for the #image command
syntax match TypstImageCommand /#image(".*")/ contained
highlight TypstImageCommand ctermfg=Magenta guifg=#FF00FF

# Define the syntax for comments
syntax match TypstComment "//.*$"
highlight TypstComment ctermfg=Gray guifg=#808080

# Underline lines starting with one or more '='
syntax match TypstUnderline /^=\+\s.*$/ contained
highlight link TypstUnderline TypstHeader

