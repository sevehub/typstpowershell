vim9script

export def Os_Sep(): string
    var sep = '/'
    if has('win32') || has('win64')
        sep = '\\'
    endif
    return sep
enddef 

