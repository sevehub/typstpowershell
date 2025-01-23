
;MIT License

;Copyright (c) 2024 Seve Tessarin

;Permission is hereby granted, free of charge, to any person obtaining a copy
;of this software and associated documentation files (the "Software"), to deal
;in the Software without restriction, including without limitation the rights
;to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
;copies of the Software, and to permit persons to whom the Software is
;furnished to do so, subject to the following conditions:

;The above copyright notice and this permission notice shall be included in all
;copies or substantial portions of the Software.

;THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
;IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
;FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
;AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
;LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
;SOFTWARE.

#Persistent
#SingleInstance, Force
; Force or Ignore
; partial match of window title
SetTitleMatchMode, 2

; Set the file path
filePath := ".pdfviewer"

; Check if the file exists
if FileExist(filePath) {
    ; Read the file content and store it in the pdfEditor variable
    FileRead, pdfEditor, %filePath%
} else {
    ; If the file doesn't exist, set the pdfEditor variable to the Windows default PDF viewer
    pdfEditor := "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"

}

; Run a PowerShell command
RunPowershellCommand(command) {
    shell := ComObjCreate("WScript.Shell")
    exec := shell.Exec("powershell.exe  -WindowStyle Hidden -Command """ . command . """")
    ; Close the stdin stream to prevent the window from waiting for input
    exec.StdIn.Close()
}


PDFViewerFocus(pdfEditor) {
        WinGet, List, List 
        Loop % List  
        {
            WinGet, EXENAME, ProcessName, % "ahk_id " List%A_Index%  
            ;WinGet, MINMAX , MinMax, % "ahk_id " List%A_Index%  

                if InStr(pdfEditor, EXENAME)
                {
                WinRestore, % "ahk_id " List%A_Index%  ;restore the window
                }
        }
}

;CTRL+ALT+WIN+Up bring the window to focus
^!#Up::
    PDFViewerFocus(pdfEditor)
    ; Send, #{%taskbarPos%}
return

^!#Down::
    PDFViewerFocus(pdfEditor)
    WinMinimize, A
return


; Hotkey to force close the editor window
^#!q::
    PDFViewerFocus(pdfEditor)
    Send, !{F4}
return

;CTRL+ALT+WIN+P open the pdfviewer
^!#p::
    RunPowershellCommand(pdfEditor)
return

; pin to the top CTRL+ALT+WIN+SPACE
^!#SPACE:: 
gosub, PintoTop
return

PintoTop:
Winset, Alwaysontop, , A
WinSet, TransColor, ffffed 230, A
return 

