# Vim9Script Plugin Typst & PowerShell


This Vim9Script plugin is designed to streamline the process of compiling Typst source code into PDF files.

Prerequisites:
- Vim (>9.0) installed on your system.
- PowerShell available.
- Typst binary https://github.com/typst/typst/releases
- A PDFViewer (SumatraPDF/Evince recommended)

Install TypstPowerShell:
- Use your preferred Vim plugin manager (e.g., vim-plug).
- Add the following line to your ~/.vimrc or vimrc:
        <pre>
        Plug 'sevehub/typstpowershell' 
        </pre>
  and then run :PlugInstall to initialize the plugin.
  Set PDFViewer's path (optional, required when different from default application):
        <pre>
        let g:pdf_viewer = 'SumatraPDF.exe' ""legacy
        g:pdf_viewer = 'SumatraPDF.exe' #vim9script
        </pre>
  Set Typst's path (optional, when not included in the PATH variable):
        <pre>
        let g:typst_exe = 'typst.exe' ""legacy
        g: = 'SumatraPDF.exe' #vim9script
        </pre>
Creating PDFs:
- Open your Typst source code in Vim.
- Execute the TypstCompile command (e.g., :TypstCompile) or save it.
- Your PDF will be generated using Typst and previewed in your PDFViewer.

Display Fonts:
- Execute TypstFonts command (:TypstFonts)

Open PDFViewer:
- :PDFViewer

You can pin the PDFViwer with the keyboard shortcut CTRL-SHIFT-SPACE (Windows only).

TODO:

[]  Documentation
[]  Complete  Vim-Doc

### PR welcomed
