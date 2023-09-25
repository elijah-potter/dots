#! /bin/bash

pandoc $1 -f markdown-implicit_figures --pdf-engine=xelatex -o out.pdf -M plot-configuration="$HOME/.config/pandoc-plot/config.yaml" --filter pandoc-plot -o $2 -V 'geometry:margin=2cm' -H ~/.config/float_placement.tex
