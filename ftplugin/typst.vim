vim9script
# Plugin:  typstpowershell  
# Description:  Minimalist Typst Plugin for PowerShell 
# Maintainer:  S. Tessarin https://tessarinseve.pythonanywhere.com/nws/index.htmlDone!
# License: GPL3
# Copyright (c) 2024 Seve Tessarin

if v:version < 900
    finish
endif

import autoload "../autoload/run_psscript.vim"
import autoload "../autoload/utils.vim"

var typst_exe = "typst.exe"
var typst_pdf_viewer = "" # same as typst.vim plugin
var powershell_version = 5
var typst_lsp_exe = "typst-lsp.exe"

if exists('g:powershell_version')
    powershell_version = g:powershell_version
endif

if exists('g:typst_exe')
    typst_exe = g:typst_exe
endif


# https://github.com/nvarner/typst-lsp/releases
if exists('g:typst_lsp_exe')
    typst_lsp_exe = g:typst_lsp_exe
endif

if exists('g:typst_pdf_viewer')
   typst_pdf_viewer = g:typst_pdf_viewer
endif

var powershellcommand = run_psscript.Create_PS_Command(powershell_version)

var plugindir =  expand('<sfile>:p:h')
var id = 0
var errom = ""
var typstfiles = []
var template = ""
var template_dir = getcwd()
var watchmode = false

if has('win32') || has('win64')
    var pintotop = "start /B " .. plugindir .. "\\" .. "pintotop.exe"
    system(pintotop)

    # TODO  read the current buffer and extract typst files unfinished 
    # var getarglist =  plugindir .. "\\" .. "getarglist.ps1 -Filename " .. expand("%:p")
    # typstfiles = systemlist(getarglist)
    # echom typstfiles
    # execute("argadd " .. join(typstfiles, " "))
endif

command -nargs=0 TypstInit TypstInit()
command -nargs=0 TypstCompile TypstCompile()
command -nargs=0 TypstWatch TypstWatch()
command -nargs=0 PDFViewer PDFViewer()
command -nargs=0 TypstFonts TypstFonts()
command -nargs=0 TypstQFList TypstQFList()


if executable(typst_lsp_exe)
  call LspAddServer([{
          name: 'typst-lsp',
          filetype: ['typst'],
          path: typst_lsp_exe,
          args: ['']
      }])
endif


augroup typstpowershell
  autocmd!
  au BufNew <buffer> :echom "New Typst Source File"
  autocmd QuickFixCmdPost [^l]* cwindow
  # if typst_pdf_viewer == ''
    #  au BufWrite <buffer> :TypstWatch
  #else
  #    au BufWrite <buffer> :TypstCompile
  # endif 
augroup END

def Popup_Input_Box(prompt: string): string
    var input = ""
    input = input(prompt, '')
    return input
enddef


def TypstInit(): void
    var pro_tpl = ""
    var arr = []
    pro_tpl = Popup_Input_Box("Enter project's template: ")
    pro_tpl = "@preview/" ..  pro_tpl
    arr = split(pro_tpl, ':')
    run_psscript.Run_PsScript(powershell_version, typst_exe .. " init " .. pro_tpl)
    # echo arr[0]
enddef

def TypstQFList(): void
    var proj_dir = getcwd()
    var curr_buff =  proj_dir .. utils.Os_Sep() .. expand("%")
    run_psscript.Run_PsScript(powershell_version, typst_exe .. " compile --diagnostic-format 'short' " .. curr_buff)
    copen
enddef


def PDFViewer(): void
    var checkbufferpath = systemlist(powershellcommand .. " " .. plugindir  .. utils.Os_Sep() .. "getpathinfo.ps1 -Path " .. expand("%:p"))
    var directory = checkbufferpath[0]
    var filename = checkbufferpath[4]
    var error = checkbufferpath[2]
    if error == ""
        var curr_pdf =  directory .. utils.Os_Sep() .. filename .. ".pdf"
        if typst_pdf_viewer == ''
            execute("!" .. curr_pdf)
            id = 1
        else
            id = term_start([typst_pdf_viewer, curr_pdf], {"hidden": true, "stoponexit": true, "term_finish": "close"})
        endif
    endif
enddef    

def TypstCompile(): void
    var checkbufferpath = systemlist(powershellcommand .. " " .. plugindir  .. utils.Os_Sep() .. "getpathinfo.ps1 -Path " .. expand("%:p"))
    var directory = checkbufferpath[0]
    var filename = checkbufferpath[1]
    var error = checkbufferpath[2]
    if error == ""
        var curr_buff =  directory .. utils.Os_Sep() .. filename
        echom curr_buff
        job_start([typst_exe, "compile", curr_buff], {
                    \ out_cb: function('TypstOutput'),
                    \ err_cb: function('TypstError'),
                    \ close_cb: function('TypstClose'), 
                    \ })
    else 
        echom error
    endif
enddef


def TypstWatch(): void
    var checkbufferpath = systemlist(powershellcommand .. " " .. plugindir  .. utils.Os_Sep() .. "getpathinfo.ps1 -Path " .. expand("%:p"))
    var directory = checkbufferpath[0]
    var filename = checkbufferpath[1]
    var error = checkbufferpath[2]
    if error == ""
        var curr_buff =  directory .. utils.Os_Sep() .. filename
        run_psscript.Run_PsScript(powershell_version, typst_exe .. " watch --diagnostic-format 'short' " .. curr_buff)
    else 
        echom error
    endif

enddef

def TypstFonts(): void
    job_start([typst_exe, "fonts"], {
                \ 'close_cb': 'FontsBuffer',
        })
enddef


def FontsBuffer(ch: channel ): void
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
        echo 'Source recompiled'
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
# vim: shiftwidth=2 softtabstop=2
