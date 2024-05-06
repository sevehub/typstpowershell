
augroup typst
        autocmd!
        autocmd  BufRead,BufNewFile *.typ set filetype=typst
        autocmd  BufRead,BufNewFile *.typ try | execute "compiler typst" | catch /./ | endtry
augroup END
