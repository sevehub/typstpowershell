# Vim9Script Plugin Typst & PowerShell

This Vim9Script plugin streamlines the process of compiling Typst source code into PDF files. It is primarily designed for a narrow set of users working in Windows PowerShell (version 5) and using VIM plus the LSP plugin. 

It should, partially at least, be compatible also with PowerShell Core. If you encounter any problems, please open an issue.

## Prerequisites:
- Vim (>9.0) installed on your system, optional AutoHotKey v.1.
- PowerShell available.
- Typst binary https://github.com/typst/typst/releases 
- A PDFViewer (SumatraPDF/Evince recommended)
- Optional Vim Lsp plugin https://github.com/yegappan/lsp. Tinymist is the default LSP server and should be included to your PowerShell PATH.  If you are using a different LSP server, set the global variable *typst_lsp_exe* to the binary's filename. 


## Install TypstPowerShell:
- Use Vim plugin manager - vim-plug.
- Add the following line to your ~/.vimrc or vimrc:
        <pre>
        Plug 'sevehub/typstpowershell' 
        </pre>
  and then run :PlugInstall to initialize the plugin.
  Set PDFViewer's path (optional, required when different from default application):
        <pre>
        let g:typst_pdf_viewer = 'SumatraPDF.exe' ""legacy
        g:typst_pdf_viewer = 'SumatraPDF.exe' #vim9script
        </pre>
  Set Typst's path (optional, when not included in the PATH variable):
        <pre>
        let g:typst_exe = 'typst.exe' ""legacy
        g:typst_exe = 'typst.exe' #vim9script
        </pre>
  Set the PowerShell's version if > 5:
        <pre>
        let g:powershell_version = 7 ""legacy
        g:powershell_version = 7 #vim9script
        </pre>
  Set Lsp binary path, if filename different form tinymist.exe and not in the PATH:
        <pre>
        let g:typst_lsp_exe = 'typst-lsp.exe' ""legacy
        g:typst_lsp_exe = 'typst-lsp.exe' #vim9script
        </pre>


## Create PDFs:
- Open your Typst source code in Vim.
- Execute the TypstCompile/TypstWatch command (e.g., :TypstCompile).
- Run the command :PDFViewer.

## Display Fonts:
- Execute TypstFonts command (:TypstFonts)

## View Errors in a quikfix list:
- :TypstQFList

## Open PDFViewer:
- :PDFViewer 
    - View the compiled document.

On Windows only, this plugin optionally provides a set of hotkeys (not enabled by default).
To enable the hotkeys, add the following to your Vim configuration:
<pre>
        let g:typstpowershell_enable_hotkeys = 1 ""legacy
        g:typstpowershell_enable_hotkeys = 1  #vim9script
</pre>
You can pin the PDFViewer with the keyboard shortcut CTRL-SHIFT-SPACE (Windows only).

## Preview Current Buffer (tinymist webserver, experimental )
- :TypstPreview

## Install TinyMist:
- :TypstInstallTM


## Initialize Project
The :TypstInit command initializes a new Typst project from the Typst universe. This command allows users to quickly set up a project with a specified template or package version. For example, using :TypstInit minimalbc:0.0.1 will create a new project based on the minimalbc template from the @preview namespace, specifically version 0.0.1. 



TODO:

[]  Documentation
[]  Complete Vim-Doc
[]  Hotkeys

### PRs welcomed

- Syntax highlighting from lsp semantic syntax
