vim9script

import autoload "../autoload/run_psscript.vim"
import autoload "../autoload/utils.vim"

var powershell_version = 5
if exists('g:powershell_version')
    powershell_version = g:powershell_version
endif
augroup typst
        autocmd!
        nnoremap <buffer> <leader>fs <Scriptcmd>ForwardSearch()<cr>
        autocmd  BufRead,BufNewFile *.typ set filetype=typst
        autocmd  BufRead,BufNewFile *.typ try | execute "compiler typst" | catch /./ | endtry
augroup END

# https://github.com/sumatrapdfreader/sumatrapdf/blob/master/docs/md/LaTeX-integration.md

# def g:BackwardSearch(line: number, filename: string)
#  exe $'buffer {bufnr(fnamemodify(filename, ':.'))}'
#  cursor(line, 1)
# enddef

def ForwardSearch()
  var filename_root = expand('%:p:r')
  run_psscript.Run_PsScript(powershell_version, $'{g:typst_pdf_viewer} -forward-search {filename_root}.typ {line(".")} {filename_root}.pdf')
enddef
