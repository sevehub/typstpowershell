vim9script

export def Create_PS_Command(ps_version: number): string
    var powershellcommand = ""
    if ps_version < 6
        powershellcommand = "powershell.exe -ExecutionPolicy Bypass -NonInteractive -NoLogo -C"

    else 
        powershellcommand = "pwsh.exe -ExecutionPolicy Bypass -NonInteractive -NoLogo -Command"
    endif
    return powershellcommand
enddef

def PowerShell_CallBack(ch: channel, msg: string)
        echom msg
enddef

def OnError(ch: channel, msg: string)
    var qfl = []
    if msg =~ 'compiled with errors'
        echo "Compiled with errors. Check the quickfix list."
    endif
    
    qfl = split(msg, '\r\n')
    if qfl->len() > 0
            call setqflist([], ' ', {'title': 'List of Errors', 'lines': qfl })
    endif
enddef

export def Run_PsScript(ps_version: number, scriptpath: string): void
    var command = Create_PS_Command(ps_version) .. ' ' .. scriptpath
    const opts = {
        "out_cb": PowerShell_CallBack,
        "err_cb": OnError
    }

    var job = job_start(command, opts)
enddef

