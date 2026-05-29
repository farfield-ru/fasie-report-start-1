#!/bin/sh
# Сборка отчёта внутри контейнера latex-g7-32 (рабочая папка /doc).
# В образе нет latexmk, поэтому прогоны xelatex и bibtex выполняются вручную.
set -eux

# Класс G7-32 и стили ГОСТ — из подмодуля.
export TEXINPUTS="/doc/latex-g7-32/G7-32/tex:/doc:"
# Стили библиографии ГОСТ (ugost2008.bst и др.).
export BSTINPUTS="/doc/latex-g7-32/GOST/bibtex/bst/gost:/doc:"
export BIBINPUTS="/doc:"

mkdir -p build

XELATEX="xelatex -interaction=nonstopmode -halt-on-error -file-line-error -shell-escape -output-directory=build"

$XELATEX report.tex          # 1-й прогон: .aux, .bcf
bibtex build/report          # библиография (стиль ugost2008)
$XELATEX report.tex          # 2-й прогон: подстановка ссылок и списка источников
$XELATEX report.tex          # 3-й прогон: стабилизация перекрёстных ссылок и оглавления

ls -l build/report.pdf
