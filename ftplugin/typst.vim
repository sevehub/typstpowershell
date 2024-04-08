vim9script
# Plugin:  typstpowershell  
# Description:  Minimalist Typst Plugin for PowerShell 
# Maintainer:  S. Tessarin https://tessarinseve.pythonanywhere.com/nws/index.htmlDone!
# License: GPL3
# Copyright (c) 2024 Seve Tessarin

if v:version < 900
    finish
endif

var typst_exe = "typst.exe"
var typst_pdf_viewer = "" # same as typst.vim plugin
var powershell_version = 5

if exists('g:powershell_version')
    powershell_version = g:powershell_version
endif

if exists('g:typst_exe')
    typst_exe = g:typst_exe
endif

if exists('g:typst_pdf_viewer')
   typst_pdf_viewer = g:typst_pdf_viewer
endif

# Powershell version 
# use pwsh.exe for version 6,7
if powershell_version < 6
    set shell=powershell.exe  
    set shellcmdflag=-Command
else 
    set shell=pwsh.exe  
    set shellcmdflag=-Command
endif

var plugindir =  expand('<sfile>:p:h')
var id = 0
var errom = ""
var sysout = ""
var typstfiles = []

if has('win32') || has('win64')
    var pintotop = plugindir .. "\\" .. "pintotop.exe"
    var powerutils =  plugindir .. "\\" .. "powerutils.ps1"
    system(pintotop)
    # typstfiles = systemlist(powerutils)
    # execute("argadd " .. join(typstfiles, " "))
endif



command -nargs=0 PSTypstCompile PSTypstCompile()
command -nargs=0 PSTypstWatch PSTypstWatch()
command -nargs=0 PDFViewer PDFViewer()
command -nargs=0 TypstFonts TypstFonts()

augroup typstpowershell
  # Remove all vimrc autocommands
  autocmd!
  au BufNew <buffer> :echom "New Typst Source File"
  if typst_pdf_viewer == ''
      au BufWrite <buffer> :PSTypstWatch
  else
      au BufWrite <buffer> :PSTypstCompile
  endif 
augroup END

def PDFViewer(): void
    var proj_dir = getcwd()
    var curr_pdf =  proj_dir .. "\\" .. expand("%:r") .. ".pdf"
    if filereadable(curr_pdf)
        if typst_pdf_viewer == ''
            execute("!" .. curr_pdf)
            id = 1
        else
            id = term_start([typst_pdf_viewer, curr_pdf], {"hidden": true, "stoponexit": true, "term_finish": "close"})
        endif
    endif
enddef    

def PSTypstCompile(): void
    var checkbufferpath = systemlist(plugindir  .. "\\getpathinfo.ps1 -Path " .. expand("%:p"))
    # echom checkbufferpath # list with Directory - Filename - Error

    var directory = checkbufferpath[0]
    var filename = checkbufferpath[1]
    var error = checkbufferpath[2]
    if error == ""
        var curr_buff =  directory .. "\\" .. filename
        job_start([typst_exe, "compile", curr_buff], {
                    \ out_cb: function('TypstOutput'),
                    \ err_cb: function('TypstError'),
                    \ close_cb: function('TypstClose'), 
                    \ })
    else 
        echom error
    endif
enddef


def PSTypstWatch(): void
    var proj_dir = getcwd()
    var curr_buff =  proj_dir .. "\\" .. expand("%")
    job_start([typst_exe, "watch", curr_buff], {
                \ out_cb: function('TypstOutput'),
                \ err_cb: function('TypstError'),
                \ close_cb: function('TypstClose'), 
                \ })
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


def TypstClose(ch: channel): void
    if errom != ''
        popup_notification(split(errom, "&&"), {
                    \ pos: 'topleft', time: 4000
                    \ })
        errom = ''
    else
        # execute('PDFViewer()')
    endif
enddef

def TypstError(ch: channel, msg: string): void
    errom = errom .. '&&' ..  msg
enddef

def TypstOutput(ch: channel, msg: string): void
    popup_notification(msg, {
           \ pos: 'topleft', time: 4000
           \ })
enddef
