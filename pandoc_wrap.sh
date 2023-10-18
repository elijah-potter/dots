#! /bin/bash

pandoc $1 \
-f markdown-implicit_figures \
--pdf-engine=xelatex \
-M plot-configuration="$HOME/.config/pandoc-plot/config.yaml" \
--filter pandoc-plot \
-o $2 \
-V 'geometry:margin=2cm' \
-H ~/.config/float_placement.tex -V colorlinks=true \
-V linkcolor=blue \
-V urlcolor=blue 
