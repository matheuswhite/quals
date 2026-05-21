# author: Claude (claude-opus-4-7)
# created: 2026-05-20
# purpose: latexmk configuration for the thesis build (main.tex).

$pdf_mode = 1;
$pdflatex = 'pdflatex -synctex=1 -interaction=nonstopmode -file-line-error %O %S';
$bibtex_use = 2;
@default_files = ('main.tex');
