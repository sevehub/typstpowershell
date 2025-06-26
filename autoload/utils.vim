vim9script

export def Os_Sep(): string
    var sep = '/'
    if has('win32') || has('win64')
        sep = '\\'
    endif
    return sep
enddef 

export def ZK_new(section: string)
  var parts = split(section, '\.')
  if len(parts) < 2
    echoerr 'Invalid format. Expecting something like 1.1A'
    return
  endif

  var dir = parts[0]
  var file = section  # substitute(section, '\.', ',', '')
  if !isdirectory(dir)
    mkdir(dir, 'p')
  endif

  var fullpath = dir .. Os_Sep() .. file .. '.typ'
  if !filereadable(fullpath)
    writefile([], fullpath)
    echomsg 'Created file: ' .. fullpath
  else
    echomsg 'File already exists: ' .. fullpath
  endif
enddef

