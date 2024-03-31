vim9script
# Plugin:  typstpowershell  
# Description:  Minimalist Typst Plugin for PowerShell 
# Maintainer:  S. Tessarin https://tessarinseve.pythonanywhere.com/nws/index.html
# License: GPL3
# Copyright (c) 2024 Seve Tessarin

if v:version < 900
    finish
endif
set shell=powershell
set shellcmdflag=-command
var typst_exe = "typst.exe"
var pdf_viewer = "SumatraPDF.exe"
var plugindir =  expand('<sfile>:p:h')
var id = 0 

if has('win32') || has('win64')
    var pintotop = plugindir .. "\\" .. "pintotop.exe"
    system(pintotop)
endif

if exists('g:typst_exe')
    typst_exe = g:typst_exe
endif

if exists('g:pdf_viewer')
   pdf_viewer = g:pdf_viewer
endif


command -nargs=0 TypstCompile TypstCompile()
command -nargs=0 TypstWatch TypstWatch()
command -nargs=0 PDFViewer PDFViewer()
command -nargs=0 TypstFonts TypstFonts()

augroup typstpowershell
  # Remove all vimrc autocommands
  autocmd!
  au BufWrite <buffer> :TypstCompile
  au BufEnter <buffer> :TypstCompile
augroup END



def PDFViewer(): void
    var proj_dir = getcwd()
    var curr_pdf =  proj_dir .. "\\" .. expand("%:r") .. ".pdf"
    id = term_start([pdf_viewer, curr_pdf], {"hidden": true, "stoponexit": true, "term_finish": "close"})
enddef    

def TypstCompile(): void
    var proj_dir = getcwd()
    var curr_buff =  proj_dir .. "\\" .. expand("%")
    if id == 0
        PDFViewer()
    endif
    job_start([typst_exe, "compile", curr_buff], {
                \ out_cb: function('TypstOutput'),
                \ err_cb: function('TypstError'),
                \ })
enddef

def TypstWatch(): void
    var proj_dir = getcwd()
    var curr_buff =  proj_dir .. "\\" .. expand("%")
    job_start([typst_exe, "watch", curr_buff])
enddef

def TypstFonts(): void
    job_start([typst_exe, "fonts"], {
                \ 'close_cb': 'FontsBuffer',
        })
enddef


def FontsBuffer(ch: channel ): void
    # echom msg
    execute("new" .. " __Fonts__")
    execute("setlocal buftype=nofile")
    while ch_status(ch, {'part': 'out'}) == 'buffered'
	    call append(line("$") - 1, "- " .. ch_read(ch))
    endwhile
enddef

def TypstError(ch: channel, msg: string): void
    popup_notification(msg, {
           \ pos: 'topleft', time: 4000
           \ })
enddef

def TypstOutput(ch: channel, msg: string): void
    popup_notification(msg, {
           \ pos: 'topleft', time: 4000
           \ })
enddef
