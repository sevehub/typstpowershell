# Vim9Script Plugin Typst & PowerShell

This Vim9Script plugin streamlines the process of compiling Typst source code into PDF files. It is primarily designed for users working in Windows PowerShell (version 5) but should also be compatible with PowerShell Core. If you encounter any problems, please open an issue.

## Prerequisites:
- Vim (>9.0) installed on your system.
- PowerShell available.
- Typst binary https://github.com/typst/typst/releases
- A PDFViewer (SumatraPDF/Evince recommended)
- Optional Vim Lsp plugin https://github.com/yegappan/lsp and https://github.com/nvarner/typst-lsp/releases binary (save to a directory in the PATH as typst-lsp.exe) for LSP integration.


## Install TypstPowerShell:
- Use your preferred Vim plugin manager (e.g., vim-plug).
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
  Set Lsp binary path, if filename different form typst-lsp.exe and not in the PATH:
        <pre>
        let g:typst_lsp_exe = 'typst-lsp.exe' ""legacy
        g:typst_lsp_exe = 'typst-lsp.exe' #vim9script
        </pre>


## Create PDFs:
- Open your Typst source code in Vim.
- Execute the TypstCompile/TypstWatch command (e.g., :TypstCompile).
- Your PDF will be generated using Typst and previewed in your PDFViewer.

## Display Fonts:
- Execute TypstFonts command (:TypstFonts)

## View Errors in a quikfix list:
- :TypstQFList

## Open PDFViewer:
- :PDFViewer

You can pin the PDFViwer with the keyboard shortcut CTRL-SHIFT-SPACE (Windows only).

## Initialize Project
The :TypstInit command initializes a new Typst project from the Typst universe. This command allows users to quickly set up a project with a specified template or package version. For example, using :TypstInit minimalbc:0.0.1 will create a new project based on the minimalbc template from the @preview namespace, specifically version 0.0.1. 



TODO:

[]  Documentation
[]  Complete Vim-Doc

### PRs welcomed


# Credits
- Syntax highlighting from  (kaarmu/typst.vim)[https://github.com/kaarmu/typst.vim]
