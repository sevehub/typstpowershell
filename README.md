# Vim9Script Plugin Typst & PowerShell


This Vim9Script plugin is designed to streamline the process of compiling Typst source code into PDF files.

Prerequisites:
- Vim (>9.0) installed on your system.
- PowerShell available.
- A PDFViewer (SumatraPDF/Evince recommended)

Install TypstPowerShell:
- Use your preferred Vim plugin manager (e.g., vim-plug).
- Add the following line to your ~/.vimrc or vimrc:
        Plug 'sevehub/typstpowershell' and run :PlugInstall to initialize the plugin.
  Set the PDFViewer path/exe name:
        let g:pdf_viewer = 'SumatraPDF.exe' ""legacy
        g:pdf_viewer = 'SumatraPDF.exe' #vim9script
Creating PDFs:
- Open your Typst source code in Vim.
- Execute the TypstPDF command (e.g., :TypstPDFCompile).
- Your PDF will be generated using Typst.


[]  Documentation
[]  Complete  Vim-Doc

### PR welcomed
