vim9script
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
  silent system($'{g:typst_pdf_viewer} -forward-search {filename_root}.typ {line(".")} {filename_root}.pdf')
enddef
